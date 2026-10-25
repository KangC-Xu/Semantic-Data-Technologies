@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0tools\Protege-5.6.9"
if errorlevel 1 goto error
if not exist "Protege.exe" goto error
start "" "Protege.exe" %*
exit /b 0
:error
echo 未找到 Protégé，请先运行本目录的 install-environment.bat。
pause
exit /b 1
