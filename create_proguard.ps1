param (
    [string]$projectPath,
    [string]$projectName,
    [string]$subdomain
)

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

# Guarda el contenido en el archivo proguard-rules.pro
Set-Content -Path (Join-Path $projectPath 'app\proguard-rules.pro') -Value $proguardRulesContent
