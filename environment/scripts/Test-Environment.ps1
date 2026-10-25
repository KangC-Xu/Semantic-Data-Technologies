$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$manifest = Get-Content -LiteralPath (Join-Path $projectRoot 'software-manifest.json') -Raw -Encoding UTF8 | ConvertFrom-Json
if ($manifest.platform -ne 'windows-x64' -or $manifest.packages.Count -ne 3) { throw '软件清单结构错误。' }
foreach ($package in $manifest.packages) {
    $length = if ($package.hashAlgorithm -eq 'SHA512') { 128 } else { 64 }
    if ($package.hash -notmatch ('^[0-9a-f]{' + $length + '}$') -or $package.url -notlike 'https://*') { throw '软件校验值或下载地址无效。' }
    if ($package.root -match '[\\/:]' -or $package.root -in @('.', '..')) { throw '软件目录不能越出 tools。' }
}
& powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -File (Join-Path $PSScriptRoot 'Install-Environment.ps1') -CheckOnly
if ($LASTEXITCODE -ne 0) { throw '环境只读自检失败。' }
$fixtureRoot = Join-Path ([IO.Path]::GetTempPath()) ('aru-environment-check-' + [guid]::NewGuid().ToString('N'))
try {
    $fixtureScripts = Join-Path $fixtureRoot 'scripts'
    $partialTool = Join-Path $fixtureRoot ('tools\' + $manifest.packages[0].root)
    New-Item -ItemType Directory -Path $fixtureScripts, $partialTool -Force | Out-Null
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'Install-Environment.ps1') -Destination $fixtureScripts
    Copy-Item -LiteralPath (Join-Path $projectRoot 'software-manifest.json') -Destination $fixtureRoot
    $marker = Join-Path $partialTool 'keep.txt'
    [IO.File]::WriteAllText($marker, 'keep')
    & powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -File (Join-Path $fixtureScripts 'Install-Environment.ps1') -CheckOnly
    if ($LASTEXITCODE -eq 0) { throw '损坏的软件目录未被拒绝。' }
    if ([IO.File]::ReadAllText($marker) -ne 'keep' -or (Test-Path -LiteralPath (Join-Path $fixtureRoot 'downloads'))) { throw '只读检查修改了软件或触发了下载。' }
} finally {
    $resolvedFixture = [IO.Path]::GetFullPath($fixtureRoot)
    if (-not $resolvedFixture.StartsWith([IO.Path]::GetFullPath([IO.Path]::GetTempPath()), [StringComparison]::OrdinalIgnoreCase)) { throw '测试目录越出临时目录，停止清理。' }
    if (Test-Path -LiteralPath $resolvedFixture) { Remove-Item -LiteralPath $resolvedFixture -Recurse }
}
Write-Host '软件清单和环境只读自检通过。'
