rem @echo off
setlocal

rem update these as appropriate
set ANDROID_SDK=C:\Apps\android\sdk
set ANT_HOME=c:\apps\apache-ant-1.10.1
set UNITY_HOME=C:\Program Files\Unity
set JDK_HOME=C:\Program Files\Java\jdk1.8.0_131

if not exist "%ANDROID_SDK%" (
    echo Must set ANDROID_SDK environment variable to the Android SDK directory.
    goto end
)

if not exist "%ANT_HOME%" (
    echo Must set ANT_HOME environment variable to the Apache Ant directory.
    goto end
)

if not exist "%UNITY_HOME%" (
    echo Must set UNITY_HOME environment variable to the Unity directory.
    goto end
)

if not exist "%JDK_HOME%" (
    echo Must set JDK_HOME environment variable to the Java Development Kit directory.
    goto end
)

path=%path%;%ANT_HOME%\bin;%ANDROID_SDK%\tools;%ANDROID_SDK%\tools\bin;%JDK_HOME%\bin

set UNITYLIBS=%UNITY_HOME%\Editor\Data\PlaybackEngines\AndroidPlayer\Variations\mono\Release\Classes\
set DSTDIR=..\..\build\Packager\Assets\Plugins\Android
set ANT_OPTS=-Dfile.encoding=UTF8
call sdkmanager --update
if errorlevel 1 goto error
if not exist libs mkdir libs
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
