param (
    [string]$projectPath,
    [string]$projectName,
    [string]$subdomain
)

# Crear directorio base del proyecto
New-Item -Path $projectPath -ItemType Directory -Force > $null

# Lista de carpetas del módulo app y subdirectorios
$appFolders = @(
    "app",
    "app\src\main\cpp",
    "app\src\main\java\com\$projectName\$subdomain",
    "app\src\main\res"
)

# Crear las carpetas
foreach ($folder in $appFolders) {
    New-Item -Path (Join-Path $projectPath $folder) -ItemType Directory -Force > $null
}
