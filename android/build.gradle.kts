plugins {
    id("com.android.application") apply false
    id("org.jetbrains.kotlin.android") apply false
    id("dev.flutter.flutter-gradle-plugin") apply false
    id("com.google.gms.google-services") version "4.4.2" apply false
}

subprojects {
    afterEvaluate {
        if (project.hasProperty("android")) {
            val extension = project.extensions.getByName("android")
            if (extension is com.android.build.gradle.BaseExtension) {
                if (extension.namespace == null) {
                    extension.namespace = "com.example.chemistry_initiative.${name.replace("-", "_")}"
                }
                extension.compileOptions {
                    sourceCompatibility = JavaVersion.VERSION_1_8
                    targetCompatibility = JavaVersion.VERSION_1_8
                }
            }
        }

        tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
            kotlinOptions {
                jvmTarget = "1.8"
            }
        }
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.layout.buildDirectory.value(rootProject.layout.buildDirectory.dir("../../build").get())

subprojects {
    project.layout.buildDirectory.value(rootProject.layout.buildDirectory.dir(project.name).get())
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
