param (
    [string]$remoteRepo  # El repositorio remoto, por ejemplo: https://github.com/user/repo.git
)

if (-not $remoteRepo) {
    Write-Host "Por favor, proporciona un repositorio remoto."
    exit 1
}

# Inicializar el repositorio Git
git init

# Agregar todos los archivos al repositorio
git add .

# Hacer un commit inicial
git commit -m "Initial commit"

# Agregar el repositorio remoto
git remote add origin $remoteRepo

# Empujar al repositorio remoto
git push -u origin main
