@echo off
chcp 65001 >nul
setlocal
title ARU Fuseki
cd /d "%~dp0"
if errorlevel 1 goto error
set "JAVA_HOME=%~dp0tools\jdk-21.0.12.1+1-jre"
set "FUSEKI_HOME=%~dp0tools\apache-jena-fuseki-6.2.0"
set "FUSEKI_BASE=%~dp0data\fuseki"
if not exist "%JAVA_HOME%\bin\java.exe" goto error
if not exist "%FUSEKI_HOME%\fuseki-server.jar" goto error
echo 正在启动 Fuseki，默认访问地址为 http://127.0.0.1:3030/
echo 运行期间请保留此窗口；关闭窗口或按 Ctrl+C 都会停止服务。
echo 数据保存在 environment\data\fuseki 目录。
"%JAVA_HOME%\bin\java.exe" -Xmx4G -cp "%FUSEKI_HOME%\fuseki-server.jar" org.apache.jena.fuseki.main.cmds.FusekiServerUICmd --localhost %*
if errorlevel 1 goto error
exit /b 0
:error
echo Fuseki 启动失败，请查看上方错误，并确认 tools 目录完整、3030 端口空闲。
pause
exit /b 1
