# Definir la ruta del archivo build.gradle
$buildGradlePath = "app/build.gradle"

# Verificar si el archivo build.gradle existe
if (-not (Test-Path $buildGradlePath)) {
    Write-Host "No se encontró el archivo build.gradle."
    exit 1
}

# Leer el contenido del archivo build.gradle
$buildGradleContent = Get-Content $buildGradlePath

# Buscar el namespace en el archivo (con o sin subdominio)
$namespacePattern = "namespace\s+'com\.(\w+(\.\w+)*)'"

# Intentar encontrar el namespace en el archivo
$packageName = $null
foreach ($line in $buildGradleContent) {
    if ($line -match $namespacePattern) {
        $packageName = $matches[1]
        break
    }
}

# Verificar si se encontró un namespace
if (-not $packageName) {
    Write-Host "No se pudo encontrar el namespace en build.gradle."
    exit 1
}

Write-Host "Desinstalando el paquete: com.$packageName"

# Ejecutar adb uninstall con el paquete extraído
adb uninstall "com.$packageName"
