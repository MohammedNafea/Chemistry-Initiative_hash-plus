plugins {
    id("com.android.application") version "8.7.0" apply false
    id("com.android.library") version "8.7.0" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
    id("dev.flutter.flutter-gradle-plugin") version "1.0.0" apply false
    id("com.google.gms.google-services") version "4.4.2" apply false
}

subprojects {
    plugins.withId("com.android.library") {
        val extension = project.extensions.getByType(com.android.build.gradle.BaseExtension::class.java)
        extension.compileSdkVersion(34)
        if (extension.namespace == null) {
            extension.namespace = "com.example.chemistry_initiative.${project.name.replace("-", "_")}"
        }
        extension.compileOptions {
            sourceCompatibility = JavaVersion.VERSION_11
            targetCompatibility = JavaVersion.VERSION_11
        }
    }
    plugins.withId("com.android.application") {
        val extension = project.extensions.getByType(com.android.build.gradle.BaseExtension::class.java)
        extension.compileSdkVersion(34)
        if (extension.namespace == null) {
            extension.namespace = "com.example.chemistry_initiative.${project.name.replace("-", "_")}"
        }
        extension.compileOptions {
            sourceCompatibility = JavaVersion.VERSION_11
            targetCompatibility = JavaVersion.VERSION_11
        }
    }

    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
        kotlinOptions {
            @Suppress("DEPRECATION")
            jvmTarget = "11"
        }
    }

    configurations.all {
        resolutionStrategy {
            eachDependency {
                if (requested.group == "org.jetbrains.kotlin") {
                    useVersion("2.1.0")
                }
                if (requested.group == "androidx.core" && (requested.name == "core" || requested.name == "core-ktx")) {
                    useVersion("1.13.1")
                }
                if (requested.group.startsWith("androidx.lifecycle")) {
                    useVersion("2.8.2")
                }
            }
        }
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://storage.googleapis.com/download.flutter.io")
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
