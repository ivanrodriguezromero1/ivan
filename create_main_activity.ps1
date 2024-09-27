param (
    [string]$projectPath,
    [string]$projectName,
    [string]$subdomain
)

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

# Crear el directorio de la actividad si no existe
$activityPath = Join-Path $projectPath "app\src\main\java\com\$projectName\$subdomain"
if (-not (Test-Path $activityPath)) {
    New-Item -Path $activityPath -ItemType Directory
}

# Guarda el contenido en el archivo MainActivity.java
Set-Content -Path (Join-Path $activityPath 'MainActivity.java') -Value $javaContent
