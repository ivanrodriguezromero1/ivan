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

# Crear directorio base del proyecto
New-Item -Path $projectPath -ItemType Directory -Force > $null

# Crear la carpeta del módulo app
New-Item -Path "$projectPath\app" -ItemType Directory -Force > $null
New-Item -Path "$projectPath\app\src\main\cpp" -ItemType Directory -Force > $null
New-Item -Path "$projectPath\app\src\main\java\com\$projectName\$subdomain" -ItemType Directory -Force > $null
New-Item -Path "$projectPath\app\src\main\res" -ItemType Directory -Force > $null

# Definir el directorio de las imágenes de ic_launcher
$sourcePath = Join-Path $PSScriptRoot "ic_launcher"

# Crear carpetas mipmap
New-Item -Path "$projectPath\app\src\main\res\mipmap-hdpi" -ItemType Directory -Force > $null
New-Item -Path "$projectPath\app\src\main\res\mipmap-mdpi" -ItemType Directory -Force > $null
New-Item -Path "$projectPath\app\src\main\res\mipmap-xhdpi" -ItemType Directory -Force > $null
New-Item -Path "$projectPath\app\src\main\res\mipmap-xxhdpi" -ItemType Directory -Force > $null
New-Item -Path "$projectPath\app\src\main\res\mipmap-xxxhdpi" -ItemType Directory -Force > $null

# Copiar las imágenes de ic_launcher a las carpetas mipmap del proyecto
Copy-Item -Path "$sourcePath\ic_launcher_hdpi.png" -Destination "$projectPath\app\src\main\res\mipmap-hdpi\ic_launcher.png" -Force
Copy-Item -Path "$sourcePath\ic_launcher_mdpi.png" -Destination "$projectPath\app\src\main\res\mipmap-mdpi\ic_launcher.png" -Force
Copy-Item -Path "$sourcePath\ic_launcher_xhdpi.png" -Destination "$projectPath\app\src\main\res\mipmap-xhdpi\ic_launcher.png" -Force
Copy-Item -Path "$sourcePath\ic_launcher_xxhdpi.png" -Destination "$projectPath\app\src\main\res\mipmap-xxhdpi\ic_launcher.png" -Force
Copy-Item -Path "$sourcePath\ic_launcher_xxxhdpi.png" -Destination "$projectPath\app\src\main\res\mipmap-xxxhdpi\ic_launcher.png" -Force

# Crear archivos con contenido predeterminado
# Contenido del archivo proguard-rules.pro
$proguardRulesContent = @"
# ProGuard rules for Android project

# Mantener todas las clases y métodos usados por las bibliotecas de Android
-keep class android.** { *; }
-keep interface android.** { *; }

# No ofuscar clases o métodos de las librerías de soporte
-keep class androidx.** { *; }

# Mantener la clase principal de la actividad
-keep class com.${projectName}.${subdomain}.MainActivity { *; }

# Mantener todos los métodos nativos (JNI) y bibliotecas usadas
-keepclasseswithmembernames class * {
    native <methods>;
}

# Regla adicional para mantener los nombres de los métodos en las excepciones
-keepattributes SourceFile,LineNumberTable
"@
Set-Content -Path "$projectPath\app\proguard-rules.pro" -Value $proguardRulesContent

# Contenido del archivo lib.cpp
if ($projectName -match "_") {
    # Si el nombre contiene un guion bajo, usar "_1" en lugar de "_"
    $cppPackageName = $projectName -replace "_", "_1"
} else {
    $cppPackageName = $projectName
}
if ($subdomain -match "_") {
    # Si el nombre contiene un guion bajo, usar "_1" en lugar de "_"
    $cppSubdomainName = $subdomain -replace "_", "_1"
} else {
    $cppSubdomainName = $subdomain
}
$cppContent = @"
#include <jni.h>
#include <string>

extern "C" JNIEXPORT jstring JNICALL
Java_com_${cppPackageName}_${cppSubdomainName}_MainActivity_stringFromJNI(
    JNIEnv* env,
    jobject /* this */) {
    std::string hello = "$projectName desde C++";
    return env->NewStringUTF(hello.c_str());
}
"@
Set-Content -Path "$projectPath\app\src\main\cpp\lib.cpp" -Value $cppContent

# Contenido del archivo MainActivity.java con el uso de lib.cpp
$javaContent = @"
package com.$projectName.$subdomain;

import android.os.Bundle;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    // Cargar la librería nativa en lib.cpp
    static {
        System.loadLibrary("lib");
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Usar el método de lib.cpp
        TextView textView = findViewById(R.id.text_view);
        textView.setText(stringFromJNI());
    }

    // Declarar el método que será implementado en C++
    public native String stringFromJNI();
}
"@
Set-Content -Path "$projectPath\app\src\main\java\com\$projectName\$subdomain\MainActivity.java" -Value $javaContent

# Contenido del archivo AndroidManifest.xml
$manifestContent = @"
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <application
        android:label="$projectName"
        android:icon="@mipmap/ic_launcher">
        <activity 
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:supportsRtl="true"
            android:theme="@style/Theme.AppCompat"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
"@
Set-Content -Path "$projectPath\app\src\main\AndroidManifest.xml" -Value $manifestContent

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
Set-Content -Path "$projectPath\build.gradle" -Value $rootGradleContent

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
Set-Content -Path "$projectPath\app\build.gradle" -Value $gradleContent

# Contenido del archivo gradle.properties
$gradlePropertiesContent = @"
android.useAndroidX=true
android.enableJetifier=true
org.gradle.jvmargs=-Xmx1536M
org.gradle.warning.mode=none
"@
Set-Content -Path "$projectPath\gradle.properties" -Value $gradlePropertiesContent

# Contenido del archivo settings.gradle
$settingsGradleContent = @"
rootProject.name = '$projectName'
include ':app'
"@
Set-Content -Path "$projectPath\settings.gradle" -Value $settingsGradleContent

# Crear el archivo CMakeLists.txt en la ruta src/main/cpp
$cmakeContent = @"
# For the C++ Hello World app
cmake_minimum_required(VERSION 3.10.2)

project($projectName) # Usa el nombre que prefieras para tu proyecto

add_library(lib SHARED lib.cpp)

find_library(log-lib log)

target_link_libraries(lib `${log-lib})
"@
Set-Content -Path "$projectPath\app\src\main\cpp\CMakeLists.txt" -Value $cmakeContent

# Crear la carpeta layout
New-Item -Path "$projectPath\app\src\main\res\layout" -ItemType Directory -Force > $null

# Crear el archivo activity_main.xml en res/layout
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
Set-Content -Path "$projectPath\app\src\main\res\layout\activity_main.xml" -Value $layoutContent

# Confirmación de creación de carpetas
Write-Host "La estructura del proyecto $projectName ha sido creada exitosamente."
