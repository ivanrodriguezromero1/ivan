param (
    [string]$projectPath
)

# Crear la carpeta layout
New-Item -Path "$projectPath\app\src\main\res\layout" -ItemType Directory -Force > $null

# Contenido del archivo activity_main.xml en res/layout
$layoutContent = @"
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical">

    <TextView
        android:id="@+id/text_view"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Hello from C++" />

</LinearLayout>
"@

# Ruta para el archivo activity_main.xml
$layoutPath = Join-Path $projectPath 'app\src\main\res\layout'

# Crear el directorio si no existe
if (-not (Test-Path $layoutPath)) {
    New-Item -Path $layoutPath -ItemType Directory
}

# Guarda el contenido en el archivo activity_main.xml
Set-Content -Path (Join-Path $layoutPath 'activity_main.xml') -Value $layoutContent
