@echo off
setlocal

if not defined ANDROID_SDK (
    echo Must set ANDROID_SDK environment variable to the Android SDK directory.
    goto end
)

if not defined ANT_HOME (
    echo Must set ANT_HOME environment variable to the Apache Ant directory.
    goto end
)

if not defined UNITY_HOME (
    echo Must set UNITY_HOME environment variable to the Unity directory.
    goto end
)

set ANDROID_SDK=C:\Apps\android-sdk
set ANT_HOME=c:\apps\apache-ant-1.9.7

path=%path%;%ANT_HOME%\bin;%ANDROID_SDK%\tools

set UNITYLIBS=%UNITY_HOME%\Editor\Data\PlaybackEngines\AndroidPlayer\Variations\mono\Release\Classes\
set DSTDIR=..\..\build\Packager\Assets\Plugins\Android
set ANT_OPTS=-Dfile.encoding=UTF8
call android update project -t android-19 -p .
if errorlevel 1 goto error
mkdir libs
copy "%UNITYLIBS%\*.*" libs
call ant "-Djava.compilerargs=-Xlint:deprecation" release
if errorlevel 1 goto error
mkdir %DSTDIR%
copy bin\classes.jar %DSTDIR%\WebViewPlugin.jar
call ant clean
if errorlevel 1 goto error
rmdir /s /q libs
rmdir /s /q res
del /q proguard-project.txt

echo BUILD SUCCEEDED!
goto end

:error
echo BUILD FAILED!
goto end

:end
endlocal