plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter plugin (must come after Android & Kotlin plugins)
    id("dev.flutter.flutter-gradle-plugin")
    // ✅ Firebase plugin
    id("com.google.gms.google-services") version "4.3.15"
}

android {
    namespace = "com.example.hospital_finder_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion ="27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.hospital_finder_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// ✅ Apply Google Services plugin at the end
apply(plugin = "com.google.gms.google-services")
