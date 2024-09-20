@echo off

if "%1"=="create" (
    powershell -ExecutionPolicy Bypass -File "%~dp0create.ps1" -projectName %2
) else if "%1"=="conectar" (
    conectar.bat
) else if "%1"=="debug" (
    gradle assembleDebug
) else if "%1"=="install" (
    adb install app/build/outputs/apk/debug/app-debug.apk
) else if "%1"=="uninstall" (
    adb uninstall com.%2
) else if "%1"=="logs" (
    adb logcat *:E | findstr com.%2
) else if "%1"=="sign" (
    powershell -ExecutionPolicy Bypass -File "%~dp0sign.ps1"
) else (
    echo Comando no válido
)