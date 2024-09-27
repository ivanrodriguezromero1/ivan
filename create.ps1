param (
    [string]$projectName,     # Nombre del proyecto
    [string]$subdomain        # Subdominio
)

if (-not $projectName) {
    Write-Host "Por favor, proporciona un nombre para el proyecto."
    exit
}

if (-not $subdomain) {
    Write-Host "Por favor, proporciona un subdominio."
    exit
}

$projectName = $projectName.ToLower()
$subdomain = $subdomain.ToLower()

# Obtener la ruta del directorio actual donde se ejecuta el script
$basePath = Get-Location

# Crear la ruta completa del proyecto
$projectPath = Join-Path $basePath $projectName

create_project_structure.ps1 -projectPath $projectPath -projectName $projectName -subdomain $subdomain

# Crear las carpetas mipmap y copiar las imágenes de ic_launcher a las carpetas mipmap del proyecto
create_mipmap_folders.ps1 -projectPath $projectPath

# Contenido del archivo proguard-rules.pro
create_proguard.ps1 -projectPath $projectPath -projectName $projectName -subdomain $subdomain

# Contenido del archivo lib.cpp
create_cpp.ps1 -projectPath $projectPath -projectName $projectName -subdomain $subdomain

# Contenido del archivo MainActivity.java con el uso de lib.cpp
create_main_activity.ps1 -projectPath $projectPath -projectName $projectName -subdomain $subdomain

# Crear archivo AndroidManifest.xml
create_manifest.ps1 -projectPath $projectPath -projectName $projectName

# Contenido del archivo build.gradle para el nivel del proyecto
create_root_gradle.ps1 -projectPath $projectPath

# Contenido del archivo build.gradle para el módulo app
create_app_gradle.ps1 -projectPath $projectPath -projectName $projectName -subdomain $subdomain

# Contenido del archivo gradle.properties
create_gradle_properties.ps1 -projectPath $projectPath

# Contenido del archivo settings.gradle
create_settings_gradle.ps1 -projectPath $projectPath -projectName $projectName

# Crear el archivo CMakeLists.txt en la ruta src/main/cpp
create_cmake.ps1 -projectPath $projectPath -projectName $projectName

# Crear el archivo activity_main.xml en res/layout
create_layout.ps1 -projectPath $projectPath

# Crear el .gitignore, pasando la ruta como argumento
create_gitignore.ps1 -projectPath $projectPath

# Confirmación de creación de carpetas
Write-Host "La estructura del proyecto $projectName ha sido creada exitosamente."
