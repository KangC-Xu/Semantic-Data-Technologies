[CmdletBinding()]
param([switch]$CheckOnly)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$repositoryRoot = Split-Path -Parent $projectRoot
$toolsRoot = Join-Path $projectRoot 'tools'
$downloadsRoot = Join-Path $projectRoot 'downloads'
$environmentFile = Join-Path $projectRoot 'environment.yml'

try {
    $cpuArchitecture = (Get-CimInstance Win32_Processor | Select-Object -First 1).Architecture
    if (-not [Environment]::Is64BitOperatingSystem -or $cpuArchitecture -ne 9) { throw '此环境需要 Windows x64，不适用于 ARM64 或 32 位系统。' }
    $manifest = Get-Content -LiteralPath (Join-Path $projectRoot 'software-manifest.json') -Raw -Encoding UTF8 | ConvertFrom-Json
    foreach ($package in $manifest.packages) {
        if ($package.root -match '[\\/:]' -or $package.root -in @('.', '..')) { throw '软件目录名称无效。' }
        $target = Join-Path $toolsRoot $package.root
        $archive = Join-Path $downloadsRoot $package.archive
        if ($CheckOnly -and (Test-Path -LiteralPath $archive -PathType Leaf)) {
            if ((Get-FileHash -LiteralPath $archive -Algorithm $package.hashAlgorithm).Hash -ine $package.hash) { throw ('缓存下载包校验失败：' + $archive) }
            Write-Host ('下载包校验通过：' + $package.archive)
        }
        if (Test-Path -LiteralPath $target) {
            foreach ($entrypoint in $package.entrypoints) {
                if (-not (Test-Path -LiteralPath (Join-Path $target $entrypoint) -PathType Leaf)) {
                    throw ('软件目录不完整，已保留且未覆盖：' + $target)
                }
            }
            Write-Host ('保留已有软件：' + $package.name + ' ' + $package.version)
            continue
        }
        if ($CheckOnly) { throw ('缺少软件：' + $package.name) }
        New-Item -ItemType Directory -Path $toolsRoot, $downloadsRoot -Force | Out-Null
        if (-not (Test-Path -LiteralPath $archive -PathType Leaf)) {
            Write-Host ('正在下载：' + $package.name)
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -UseBasicParsing -Uri $package.url -OutFile $archive -TimeoutSec 180
        }
        if ((Get-FileHash -LiteralPath $archive -Algorithm $package.hashAlgorithm).Hash -ine $package.hash) {
            throw ('下载包校验失败，未解压；请检查后重新下载：' + $archive)
        }
        Expand-Archive -LiteralPath $archive -DestinationPath $toolsRoot
        foreach ($entrypoint in $package.entrypoints) {
            if (-not (Test-Path -LiteralPath (Join-Path $target $entrypoint) -PathType Leaf)) {
                throw ('解压后缺少程序文件：' + $target)
            }
        }
        Write-Host ('软件就绪：' + $package.name)
    }

    foreach ($name in @('chinese-ui-1.0.1.jar', 'rdf-library-compat-1.0.0.jar')) {
        $source = Join-Path $repositoryRoot ('plugins\chinese-ui-plugin\dist\' + $name)
        $target = Join-Path $toolsRoot ('Protege-5.6.9\plugins\' + $name)
        if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
            if (Test-Path -LiteralPath $target -PathType Leaf) { Write-Host ('保留已安装插件：' + $name); continue }
            throw ('缺少插件源和已安装文件，请保留完整项目的 plugins 目录：' + $name)
        }
        if (Test-Path -LiteralPath $target -PathType Leaf) {
            if ((Get-FileHash -LiteralPath $source).Hash -eq (Get-FileHash -LiteralPath $target).Hash) { continue }
            if ($CheckOnly) { throw ('插件与仓库版本不一致：' + $target) }
            Copy-Item -LiteralPath $target -Destination ($target + '.' + (Get-Date -Format 'yyyyMMdd-HHmmssfff') + '.bak')
        } elseif ($CheckOnly) { throw ('缺少插件：' + $target) }
        Copy-Item -LiteralPath $source -Destination $target -Force
    }

    $condaCandidates = @()
    if ($env:CONDA_EXE) { $condaCandidates += $env:CONDA_EXE }
    $condaCommand = Get-Command conda.exe -ErrorAction SilentlyContinue
    if ($condaCommand) { $condaCandidates += $condaCommand.Source }
    $condaBat = Get-Command conda.bat -ErrorAction SilentlyContinue
    if ($condaBat) { $condaCandidates += Join-Path (Split-Path (Split-Path $condaBat.Source -Parent) -Parent) 'Scripts\conda.exe' }
    foreach ($location in @('D:\miniconda3', 'C:\miniconda3', (Join-Path $env:USERPROFILE 'miniconda3'), (Join-Path $env:LOCALAPPDATA 'miniconda3'), (Join-Path $env:ProgramData 'miniconda3'))) {
        $condaCandidates += Join-Path $location 'Scripts\conda.exe'
    }
    $condaExe = $condaCandidates | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } | Select-Object -First 1
    if (-not $condaExe) { throw '未找到 Miniconda。请从 https://www.anaconda.com/docs/getting-started/miniconda/install 安装，再重新运行本文件；不要把课程依赖装进 base。' }
    $envList = & $condaExe env list --json
    if ($LASTEXITCODE -ne 0) { throw '读取 Conda 环境失败。' }
    $aruEnvs = @((($envList -join "`n") | ConvertFrom-Json).envs | Where-Object { (Split-Path $_ -Leaf) -ieq 'ARU' })
    $environmentText = Get-Content -LiteralPath $environmentFile -Raw -Encoding UTF8
    # shortcut: 仅解析本仓库固定缩进的依赖清单，使用复杂 YAML 时再改为完整解析。
    $dependencyText = ($environmentText -split '(?m)^dependencies:[ \t]*\r?\n', 2)[1]
    $condaPackages = @([regex]::Matches($dependencyText, '(?m)^  - ([\w.-]+(?:=[^:\s]+)?)[ \t]*\r?$') | ForEach-Object { $_.Groups[1].Value })
    $pipPackages = @([regex]::Matches($environmentText, '(?m)^\s*-\s*([\w.-]+==[^\s]+)[ \t]*\r?$') | ForEach-Object { $_.Groups[1].Value })
    if ($condaPackages.Count -lt 3 -or $pipPackages.Count -eq 0) { throw 'environment.yml 的依赖清单为空或格式不完整。' }
    if ($aruEnvs.Count -eq 0) {
        if ($CheckOnly) { throw '未找到 ARU 环境，请运行 install-environment.bat。' }
        & $condaExe create --name ARU --override-channels --channel conda-forge @condaPackages --yes
        if ($LASTEXITCODE -ne 0) { throw '创建 ARU 环境失败，请查看上方首个错误；已有环境未删除。' }
        $envList = & $condaExe env list --json
        if ($LASTEXITCODE -ne 0) { throw '读取新环境失败。' }
        $aruEnvs = @((($envList -join "`n") | ConvertFrom-Json).envs | Where-Object { (Split-Path $_ -Leaf) -ieq 'ARU' })
    }
    if ($aruEnvs.Count -ne 1) { throw 'ARU 环境位置不唯一或创建失败，请先检查 conda env list。' }
    $pythonExe = Join-Path $aruEnvs[0] 'python.exe'
    if (-not (Test-Path -LiteralPath $pythonExe -PathType Leaf)) { throw 'ARU 环境缺少 Python，已保留环境且未覆盖。' }
    if (-not $CheckOnly) {
        Write-Host '正在按 environment.yml 补齐 ARU 课程依赖，不清空环境。'
        & $condaExe install --prefix $aruEnvs[0] --override-channels --channel conda-forge @condaPackages --yes
        if ($LASTEXITCODE -ne 0) { throw '更新 ARU 的 Python/SQLite 失败，请查看上方首个错误；未删除环境。' }
        & $pythonExe -m pip install @pipPackages
        if ($LASTEXITCODE -ne 0) { throw '更新 ARU 的课程依赖失败，请查看上方首个错误；可修复后重新运行。' }
    }
    $verifyCode = @'
import importlib.metadata as metadata
from pathlib import Path
import re
import sqlite3
import sys
spec = Path(sys.argv[1]).read_text(encoding='utf-8-sig')
python_version = re.search(r'^  - python=([^\s]+)', spec, re.MULTILINE).group(1)
sqlite_version = re.search(r'^  - libsqlite=([^\s]+)', spec, re.MULTILINE).group(1)
assert '.'.join(map(str, sys.version_info[:3])) == python_version, 'Python 版本与 environment.yml 不一致'
assert sqlite3.sqlite_version == sqlite_version, 'SQLite 运行时与 environment.yml 不一致'
for name, version in re.findall(r'^\s*-\s*([\w.-]+)==([^\s]+)\s*$', spec, re.MULTILINE):
    assert metadata.version(name) == version, f'{name} 版本与 environment.yml 不一致'
import socket
import nltk
import matplotlib
import numpy
from PIL import Image
from SPARQLWrapper import SPARQLWrapper
print('ARU 的 Python 及课程依赖版本验证通过')
'@
    & $pythonExe -X utf8 -c $verifyCode $environmentFile
    if ($LASTEXITCODE -ne 0) { throw 'ARU 环境与依赖清单不一致；请运行 install-environment.bat 更新，或根据上方首个错误检查。' }
    & $pythonExe -m pip check
    if ($LASTEXITCODE -ne 0) { throw 'ARU 存在依赖冲突，请查看上方错误；未删除环境。' }
    if (-not $CheckOnly) {
        & $pythonExe -m ipykernel install --sys-prefix --name aru --display-name 'Python (ARU)'
        if ($LASTEXITCODE -ne 0) { throw '注册 Python (ARU) 内核失败。' }
    }
    $kernelCheck = @'
from pathlib import Path
import sys
from jupyter_client.kernelspec import KernelSpecManager
assert Path(KernelSpecManager().get_kernel_spec('aru').argv[0]).resolve() == Path(sys.executable).resolve(), 'ARU 内核解释器不匹配'
'@
    & $pythonExe -X utf8 -c $kernelCheck
    if ($LASTEXITCODE -ne 0) { throw 'ARU 内核缺失或路径不正确；请重新运行安装入口注册内核。' }
    Write-Host '软件及 ARU 环境已就绪；可以使用本目录的 start-*.bat。'
} catch {
    Write-Host ('环境准备未完成：' + $_.Exception.Message) -ForegroundColor Red
    exit 1
}
