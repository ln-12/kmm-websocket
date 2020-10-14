buildscript {
    repositories {
        gradlePluginPortal()
        jcenter()
        google()
        mavenCentral()
    }

    val kotlinVersion = "1.4.0"
    val sqlDelightVersion: String by project

    dependencies {
        classpath("com.android.tools.build:gradle:4.1.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
        classpath("org.jetbrains.kotlin:kotlin-serialization:$kotlinVersion")
        classpath("org.jetbrains.kotlin:kotlin-android-extensions:$kotlinVersion")
    }
}



group = "com.jetbrains.handson"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}
