param (
    [string]$projectPath # Ruta donde se creará el .gitignore
)

# Ruta completa del archivo .gitignore
$gitignorePath = Join-Path $projectPath ".gitignore"

# Contenido del archivo .gitignore
$gitignoreContent = @"
# Excluir carpetas y archivos generados automaticamente
.gradle
.idea
gradle/
gradlew
gradlew.bat
local.properties

# Excluir archivos de compilacion
app/build
app/.cxx
"@

# Crear o sobrescribir el archivo .gitignore con el contenido especificado
Set-Content -Path $gitignorePath -Value $gitignoreContent
