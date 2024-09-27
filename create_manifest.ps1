param (
    [string]$projectPath,
    [string]$projectName
)

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

# Guarda el contenido en el archivo AndroidManifest.xml
Set-Content -Path "$projectPath\app\src\main\AndroidManifest.xml" -Value $manifestContent
