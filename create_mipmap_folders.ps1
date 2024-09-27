param (
    [string]$projectPath
)

# Definir las resoluciones de mipmap
$mipmapFolders = @("mipmap-hdpi", "mipmap-mdpi", "mipmap-xhdpi", "mipmap-xxhdpi", "mipmap-xxxhdpi")

# Crear las carpetas mipmap
foreach ($folder in $mipmapFolders) {
    New-Item -Path (Join-Path $projectPath "app\src\main\res\$folder") -ItemType Directory -Force > $null
}

# Definir el directorio de las imágenes de ic_launcher
$sourcePath = Join-Path $PSScriptRoot "ic_launcher"

# Definir un hash table para asociar resoluciones de mipmap con sus archivos correspondientes
$imageFiles = @{
    "mipmap-hdpi" = "ic_launcher_hdpi.png"
    "mipmap-mdpi" = "ic_launcher_mdpi.png"
    "mipmap-xhdpi" = "ic_launcher_xhdpi.png"
    "mipmap-xxhdpi" = "ic_launcher_xxhdpi.png"
    "mipmap-xxxhdpi" = "ic_launcher_xxxhdpi.png"
}

# Copiar las imágenes de ic_launcher a las carpetas mipmap del proyecto
foreach ($folder in $mipmapFolders) {
    $sourceImage = Join-Path $sourcePath $imageFiles[$folder]
    $destinationImage = Join-Path $projectPath "app\src\main\res\$folder\ic_launcher.png"
    Copy-Item -Path $sourceImage -Destination $destinationImage -Force
}
