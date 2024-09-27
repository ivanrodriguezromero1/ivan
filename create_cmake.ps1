param (
    [string]$projectPath,
    [string]$projectName
)

# Contenido del archivo CMakeLists.txt en la ruta src/main/cpp
$cmakeContent = @"
# For the C++ Hello World app
cmake_minimum_required(VERSION 3.10.2)

project($projectName) # Usa el nombre que prefieras para tu proyecto

add_library(lib SHARED lib.cpp)

find_library(log-lib log)

# Corregir el paréntesis en target_link_libraries
target_link_libraries(lib `${log-lib})
"@

# Ruta para el archivo CMakeLists.txt
$cppPath = Join-Path $projectPath 'app\src\main\cpp'

# Crear el directorio si no existe
if (-not (Test-Path $cppPath)) {
    New-Item -Path $cppPath -ItemType Directory
}

# Guarda el contenido en el archivo CMakeLists.txt
Set-Content -Path (Join-Path $cppPath 'CMakeLists.txt') -Value $cmakeContent
