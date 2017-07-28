@echo off
setlocal

rem Update these for your environment
set JAVA_HOME=%ProgramFiles%\Java\jdk1.8.0_131
set VV_REPO_ROOT=v:\git\VV\Unity-Collaborate-2
set UNITY_HOME=c:\apps\Unity\2017.1.0p1

path=%path%;%JAVA_HOME%\bin

if exist bin rmdir /s /q bin
if exist gradle_build\libs rmdir /s /q gradle_build\libs
if exist gradle_build\src rmdir /s /q gradle_build\src

mkdir bin
mkdir gradle_build\libs
mkdir gradle_build\src
mkdir gradle_build\src\main
mkdir gradle_build\src\main\java

copy /b "%UNITY_HOME%\Editor\Data\PlaybackEngines\AndroidPlayer\Variations\mono\Release\Classes\classes.jar" gradle_build\libs >nul
xcopy /s /e src gradle_build\src\main\java >nul
copy /b AndroidManifest.xml gradle_build\src\main >nul

call gradlew.bat assembleRelease

jar cf bin\WebViewPlugin.jar -C gradle_build\build\intermediates\classes\release net

endlocal
