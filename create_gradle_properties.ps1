param (
    [string]$projectPath
)

# Contenido del archivo gradle.properties
$gradlePropertiesContent = @"
android.useAndroidX=true
android.enableJetifier=true
org.gradle.jvmargs=-Xmx1536M
org.gradle.warning.mode=none
"@

# Guarda el contenido en el archivo gradle.properties
Set-Content -Path (Join-Path $projectPath 'gradle.properties') -Value $gradlePropertiesContent
