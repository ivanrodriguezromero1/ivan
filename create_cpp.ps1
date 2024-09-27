param (
    [string]$projectPath,
    [string]$projectName,
    [string]$subdomain
)

# Manejo de guiones bajos en projectName y subdomain
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

# Contenido del archivo lib.cpp
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

# Guarda el contenido en el archivo lib.cpp
Set-Content -Path (Join-Path $projectPath 'app\src\main\cpp\lib.cpp') -Value $cppContent
