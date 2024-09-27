param (
    [string]$projectPath
)

# Contenido del archivo build.gradle para el nivel del proyecto
$rootGradleContent = @"
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.1.4'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
"@

# Guarda el contenido en el archivo build.gradle en el nivel del proyecto
Set-Content -Path (Join-Path $projectPath 'build.gradle') -Value $rootGradleContent
