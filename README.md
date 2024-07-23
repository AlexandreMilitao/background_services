# background_services

## Getting Started

Em android/app/build.gradle
    Utilizar compileSdkVersion 34 

Em android/seetings.gradle
    adcionar em plugins(ultimo plugins que aparece nesse arquivo)
        id "org.jetbrains.kotlin.android" version "1.8.10" apply false

Em android/app/src/main/AndroidManifest.xml
    
    adicionar esse código a cima de <application
        <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
        <!-- Tell Google Play Store that your app uses Bluetooth LE
         Set android:required="true" if bluetooth is necessary -->
        <uses-feature android:name="android.hardware.bluetooth_le" android:required="true" />

        <!-- New Bluetooth permissions in Android 12
        https://developer.android.com/about/versions/12/features/bluetooth-permissions -->
        <uses-permission android:name="android.permission.BLUETOOTH_SCAN"/>
        <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
        <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />

        <!-- legacy for Android 11 or lower -->
        <uses-permission android:name="android.permission.BLUETOOTH" android:maxSdkVersion="30" />
        <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" android:maxSdkVersion="30" />
        <!-- legacy for Android 9 or lower -->
        <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" android:maxSdkVersion="28" />
    
    adicionar esse código apos </activity>
        <service
            android:name="id.flutter.flutter_background_service.BackgroundService"
            android:foregroundServiceType="location"
        />


Em android/build.gradle
    colocar
        ext.kotlin_version = '1.8.10'
