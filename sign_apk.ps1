# Obtener la ubicación release
$releasePath = Join-Path (Get-Location) "app\build\outputs\apk\release"
$keystorePath = "$releasePath\my-release-key.jks"

if (-not (Test-Path $keystorePath)) {
    Write-Host "Creando el archivo de clave (keystore)..."
    & keytool -genkey -v -keystore $keystorePath -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias
}

Write-Host "Firmando la APK..."
$unsignedApkPath = Join-Path $releasePath "app-release-unsigned.apk"
& jarsigner -verbose -keystore $keystorePath $unsignedApkPath my-key-alias
