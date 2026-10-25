@echo off
chcp 65001 >nul
setlocal
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -File "%~dp0scripts\Install-Environment.ps1" %*
if errorlevel 1 (
    echo 安装未完成，请查看上方错误信息。
    pause
    exit /b 1
)
echo 环境检查及安装完成。
pause
