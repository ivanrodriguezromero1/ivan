@echo off
if "%1"=="" (
    echo Por favor, proporciona el nombre del paquete, por ejemplo: com.aplicacion
    exit /b 1
)

set PACKAGE_NAME=%1

cmd /c "adb logcat *:E | findstr %PACKAGE_NAME%"
