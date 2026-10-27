@echo off
chcp 65001 >nul
setlocal
title Week3 Library Fuseki
cd /d "%~dp0"
if errorlevel 1 goto failed
rem 优先使用仓库软件，单独复制时读取标准环境变量 / Prefer repository tools; use standard variables for a standalone copy.
set "WEEK3_JAVA="
set "WEEK3_FUSEKI="
if defined JAVA_HOME if exist "%JAVA_HOME%\bin\java.exe" set "WEEK3_JAVA=%JAVA_HOME%\bin\java.exe"
if defined FUSEKI_HOME if exist "%FUSEKI_HOME%\fuseki-server.jar" set "WEEK3_FUSEKI=%FUSEKI_HOME%\fuseki-server.jar"
if exist "%~dp0..\..\environment\tools\jdk-21.0.12.1+1-jre\bin\java.exe" set "WEEK3_JAVA=%~dp0..\..\environment\tools\jdk-21.0.12.1+1-jre\bin\java.exe"
if exist "%~dp0..\..\environment\tools\apache-jena-fuseki-6.2.0\fuseki-server.jar" set "WEEK3_FUSEKI=%~dp0..\..\environment\tools\apache-jena-fuseki-6.2.0\fuseki-server.jar"
if not defined WEEK3_JAVA goto missing
if not defined WEEK3_FUSEKI goto missing
set "WEEK3_PORT=3030"
if not "%~1"=="" set "WEEK3_PORT=%~1"
set "FUSEKI_BASE=%~dp0.runtime\fuseki"
echo 图书库 / Library: http://127.0.0.1:%WEEK3_PORT%/library/query
echo 数据位置 / Data folder: "%~dp0data\fuseki\library"
echo 停止请按 Ctrl+C / Press Ctrl+C to stop.
"%WEEK3_JAVA%" -Xmx1G -cp "%WEEK3_FUSEKI%" org.apache.jena.fuseki.main.cmds.FusekiServerUICmd --localhost --port="%WEEK3_PORT%" --config="%~dp0fuseki-library.ttl"
if errorlevel 1 goto failed
exit /b 0
:missing
echo 请先双击仓库 environment\install-environment.bat 安装环境。
echo Run environment\install-environment.bat in the repository first.
echo 单独使用时需要 Java 21 和 Fuseki 6.2.0，并设置 JAVA_HOME 与 FUSEKI_HOME。
echo For a standalone copy, install Java 21 and Fuseki 6.2.0 and set JAVA_HOME and FUSEKI_HOME.
goto failed
:failed
echo 启动失败，请检查上方错误或端口占用 / Startup failed; check the error above or a port conflict.
pause
exit /b 1
