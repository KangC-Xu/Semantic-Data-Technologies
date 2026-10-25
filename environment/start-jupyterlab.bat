@echo off
chcp 65001 >nul
setlocal
set "ARU_CONDA_BAT="
if defined CONDA_EXE for %%I in ("%CONDA_EXE%") do if exist "%%~dpI..\condabin\conda.bat" set "ARU_CONDA_BAT=%%~dpI..\condabin\conda.bat"
for /f "delims=" %%I in ('where conda.bat conda.exe 2^>nul') do if not defined ARU_CONDA_BAT if exist "%%~dpI..\condabin\conda.bat" set "ARU_CONDA_BAT=%%~dpI..\condabin\conda.bat"
for %%I in ("%USERPROFILE%\miniconda3" "%LOCALAPPDATA%\miniconda3" "%ProgramData%\miniconda3" "C:\miniconda3" "D:\miniconda3") do if not defined ARU_CONDA_BAT if exist "%%~I\condabin\conda.bat" set "ARU_CONDA_BAT=%%~I\condabin\conda.bat"
if not defined ARU_CONDA_BAT (
    echo 未找到 Miniconda，请先安装，再从 Miniconda Prompt 运行本文件。
    goto :failed
)
call "%ARU_CONDA_BAT%" activate ARU
if errorlevel 1 goto :failed
cd /d "%~dp0.."
if errorlevel 1 goto :failed
python -m jupyterlab --ServerApp.root_dir="%CD%" --LabApp.user_settings_dir="%~dp0config\jupyter\user-settings" %*
if errorlevel 1 goto :failed
exit /b 0

:failed
echo 启动失败，请查看上面的错误信息。
pause
exit /b 1
