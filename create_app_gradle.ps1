param (
    [string]$projectPath,
    [string]$projectName,
    [string]$subdomain
)

# Obtener el NDK path desde la variable de entorno
$ndkPath = $Env:ANDROID_NDK_HOME -replace '\\', '\\'

# Contenido del archivo build.gradle para el módulo app
$gradleContent = @"
plugins {
    id 'com.android.application'
}

android {
    namespace 'com.$projectName.$subdomain'
    compileSdkVersion 35
    defaultConfig {
        applicationId "com.$projectName.$subdomain"
        minSdkVersion 21
        targetSdkVersion 35
        versionCode 1
        versionName "1.0"
        ndkPath "$ndkPath"

        // Configuración para cmake y lib.cpp
        externalNativeBuild {
            cmake {
                cppFlags ""
            }
        }
    }
    buildTypes {
        release {
            shrinkResources true
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
    externalNativeBuild {
        cmake {
            path "src/main/cpp/CMakeLists.txt"
        }
    }
}

dependencies {
    implementation 'androidx.appcompat:appcompat:1.2.0'
    implementation 'androidx.core:core-ktx:1.3.2'
}
"@

# Guarda el contenido en el archivo build.gradle en el módulo app
Set-Content -Path (Join-Path $projectPath 'app\build.gradle') -Value $gradleContent
