@echo off
setlocal

rem Update these for your environment
set JAVA_HOME=%ProgramFiles%\Java\jdk1.8.0_131
set VV_REPO_ROOT=v:\git\VV\Unity3D-Alpha-2
path=%path%;%JAVA_HOME%\bin

if exist bin rmdir /s /q bin
if exist gradle_build\libs rmdir /s /q gradle_build\libs
if exist gradle_build\src rmdir /s /q gradle_build\src

mkdir bin
mkdir gradle_build\libs
mkdir gradle_build\src
mkdir gradle_build\src\main
mkdir gradle_build\src\main\java

copy /b "%ProgramFiles%\Unity\Editor\Data\PlaybackEngines\AndroidPlayer\Variations\mono\Release\Classes\classes.jar" gradle_build\libs >nul
copy /b "%VV_REPO_ROOT%\Assets\Plugins\Android\unityvractivity.aar" gradle_build\libs >nul
xcopy /s /e src gradle_build\src\main\java >nul
copy /b AndroidManifest.xml gradle_build\src\main >nul

call gradlew.bat assembleRelease

jar cf bin\WebViewPlugin.jar -C gradle_build\build\intermediates\classes\release net

endlocal
