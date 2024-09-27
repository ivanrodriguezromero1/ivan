param (
    [string]$projectPath,
    [string]$projectName
)

# Contenido del archivo settings.gradle
$settingsGradleContent = @"
rootProject.name = '$projectName'
include ':app'
"@

# Guarda el contenido en el archivo settings.gradle
Set-Content -Path (Join-Path $projectPath 'settings.gradle') -Value $settingsGradleContent
