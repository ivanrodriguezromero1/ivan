@echo off

:: Verificar si el primer parámetro es "create"
if "%1"=="create" (
    :: Llamar a PowerShell para ejecutar el script create_project.ps1 con el nombre del proyecto
    powershell -ExecutionPolicy Bypass -File "%~dp0create_project.ps1" -projectName %2
) else if "%1"=="sign" (
    :: Llamar a PowerShell para ejecutar el script sign_apk.ps1
    powershell -ExecutionPolicy Bypass -File "%~dp0sign_apk.ps1"
) else if "%1"=="conectar" (
    conectar_adb.bat
) else (
    echo Comando no válido. Usa: ivan create [nombre-del-proyecto] o ivan sign
)

