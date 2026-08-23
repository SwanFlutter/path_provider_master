
## 1.0.2

- **Android — AGP 9 compatibility**: Fixed `compileDebugKotlin` incremental cache lock conflict (`Storage is already registered`) caused by parallel Kotlin daemon instances. Set `org.gradle.parallel=false` and `org.gradle.daemon=false` in `gradle.properties`
- **Android — KGP double-apply fix**: Removed duplicate AGP version check in `android/build.gradle.kts`; KGP is now applied once via a single `builtInKotlin` guard
- **Android — KotlinAndroidProjectExtension**: Wrapped `compilerOptions` in `afterEvaluate` to safely configure JVM target regardless of plugin apply order
- **Android — KGP version alignment**: Aligned KGP to `2.2.20` across plugin and example `settings.gradle.kts`
- **Example — release signing**: Removed `signingConfig = signingConfigs.getByName("debug")` from release build type (not needed for testing)

## 1.0.1

- **WASM compatibility**: Replaced unconditional `dart:io` import with conditional import, enabling compatibility with the WASM runtime
- **Swift Package Manager support**: Added `PrivacyInfo.xcprivacy` resource to iOS and macOS SPM targets
- **Android built-in Kotlin**: Migrated `android/build.gradle.kts` from legacy `buildscript {}` pattern to built-in Kotlin plugin via the `plugins {}` block

## 1.0.0

- **Initial implementation** of the Path Provider Master plugin
- **Full support** for all standard `path_provider` methods
- **New public directory methods** added:
  - `getPublicPicturesDirectory()`
  - `getPublicVideosDirectory()`
  - `getPublicMusicDirectory()`
  - `getPublicDownloadsDirectory()`
  - `getPublicDocumentsDirectory()`
  - `getPublicDCIMDirectory()`
- **Cross-platform support**: Android, iOS, Windows, macOS, and Linux
- **Complete example** with a Persian user interface

---
