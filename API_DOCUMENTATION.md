# Path Provider Master – API Documentation

---

## Table of Contents
- [Standard Methods](#standard-methods)
- [Public Methods](#public-methods)
- [Practical Examples](#practical-examples)

---

## Standard Methods

### `getTemporaryDirectory()`
```dart
static Future<Directory?> getTemporaryDirectory()
```
**Description:** Retrieves the system's temporary directory. Files here may be deleted by the OS.
**Platforms:** ✅ Android | ✅ iOS | ✅ Windows | ✅ macOS | ✅ Linux
**Example:**
```dart
final tempDir = await PathProviderMaster.getTemporaryDirectory();
print('Temp: ${tempDir?.path}');
```

---

### `getApplicationSupportDirectory()`
```dart
static Future<Directory?> getApplicationSupportDirectory()
```
**Description:** Retrieves the application support directory. Suitable for storing app support files and data.
**Platforms:** ✅ Android | ✅ iOS | ✅ Windows | ✅ macOS | ✅ Linux
**Example:**
```dart
final supportDir = await PathProviderMaster.getApplicationSupportDirectory();
final dbFile = File('${supportDir?.path}/app.db');
```

---

### `getLibraryDirectory()`
```dart
static Future<Directory?> getLibraryDirectory()
```
**Description:** Retrieves the Library directory (specific to iOS and macOS).
**Platforms:** ❌ Android | ✅ iOS | ❌ Windows | ✅ macOS | ❌ Linux
**Example:**
```dart
final libraryDir = await PathProviderMaster.getLibraryDirectory();
if (libraryDir != null) {
  print('Library: ${libraryDir.path}');
}
```

---

### `getApplicationDocumentsDirectory()`
```dart
static Future<Directory?> getApplicationDocumentsDirectory()
```
**Description:** Retrieves the application documents directory. Suitable for storing user files.
**Platforms:** ✅ Android | ✅ iOS | ✅ Windows | ✅ macOS | ✅ Linux
**Example:**
```dart
final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
final userFile = File('${docsDir?.path}/user_data.json');
```

---

### `getExternalStorageDirectory()`
```dart
static Future<Directory?> getExternalStorageDirectory()
```
**Description:** Retrieves the external storage directory (specific to Android).
**Platforms:** ✅ Android | ❌ iOS | ❌ Windows | ❌ macOS | ❌ Linux
**Permission Required:** Yes (Android)
```xml
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```
**Example:**
```dart
final externalDir = await PathProviderMaster.getExternalStorageDirectory();
if (externalDir != null) {
  print('External: ${externalDir.path}');
}
```

---

### `getExternalCacheDirectories()`
```dart
static Future<List<Directory>?> getExternalCacheDirectories()
```
**Description:** Retrieves a list of external cache directories (specific to Android).
**Platforms:** ✅ Android | ❌ iOS | ❌ Windows | ❌ macOS | ❌ Linux
**Example:**
```dart
final cacheDirs = await PathProviderMaster.getExternalCacheDirectories();
if (cacheDirs != null) {
  for (var dir in cacheDirs) {
    print('Cache: ${dir.path}');
  }
}
```

---

### `getExternalStorageDirectories()`
```dart
static Future<List<Directory>?> getExternalStorageDirectories()
```
**Description:** Retrieves a list of external storage directories (specific to Android).
**Platforms:** ✅ Android | ❌ iOS | ❌ Windows | ❌ macOS | ❌ Linux
**Example:**
```dart
final storageDirs = await PathProviderMaster.getExternalStorageDirectories();
if (storageDirs != null) {
  for (var dir in storageDirs) {
    print('Storage: ${dir.path}');
  }
}
```

---

### `getDownloadsDirectory()`
```dart
static Future<Directory?> getDownloadsDirectory()
```
**Description:** Retrieves the Downloads directory.
**Platforms:** ✅ Android | ✅ iOS | ✅ Windows | ✅ macOS | ✅ Linux
**Example:**
```dart
final downloadsDir = await PathProviderMaster.getDownloadsDirectory();
final downloadedFile = File('${downloadsDir?.path}/file.pdf');
```

---

## Public Methods

### `getPublicPicturesDirectory()`
```dart
static Future<Directory?> getPublicPicturesDirectory()
```
**Description:** Retrieves the public Pictures directory.
**Platforms:** ✅ Android | ✅ iOS | ✅ Windows | ✅ macOS | ✅ Linux
**Example:**
```dart
final picturesDir = await PathProviderMaster.getPublicPicturesDirectory();
final image = File('${picturesDir?.path}/photo.jpg');
```

---

### `getPublicVideosDirectory()`
```dart
static Future<Directory?> getPublicVideosDirectory()
```
**Description:** Retrieves the public Videos directory.
**Platforms:** ✅ Android | ✅ iOS | ✅ Windows | ✅ macOS | ✅ Linux
**Example:**
```dart
final videosDir = await PathProviderMaster.getPublicVideosDirectory();
final video = File('${videosDir?.path}/video.mp4');
```

---

### `getPublicMusicDirectory()`
```dart
static Future<Directory?> getPublicMusicDirectory()
```
**Description:** Retrieves the public Music directory.
**Platforms:** ✅ Android | ✅ iOS | ✅ Windows | ✅ macOS | ✅ Linux
**Example:**
```dart
final musicDir = await PathProviderMaster.getPublicMusicDirectory();
final song = File('${musicDir?.path}/song.mp3');
```

---

### `getPublicDownloadsDirectory()`
```dart
static Future<Directory?> getPublicDownloadsDirectory()
```
**Description:** Retrieves the public Downloads directory.
**Platforms:** ✅ Android | ✅ iOS | ✅ Windows | ✅ macOS | ✅ Linux
**Example:**
```dart
final downloadsDir = await PathProviderMaster.getPublicDownloadsDirectory();
final file = File('${downloadsDir?.path}/document.pdf');
```

---

### `getPublicDocumentsDirectory()`
```dart
static Future<Directory?> getPublicDocumentsDirectory()
```
**Description:** Retrieves the public Documents directory.
**Platforms:** ✅ Android | ✅ iOS | ✅ Windows | ✅ macOS | ✅ Linux
**Example:**
```dart
final docsDir = await PathProviderMaster.getPublicDocumentsDirectory();
final doc = File('${docsDir?.path}/report.docx');
```

---

### `getPublicDCIMDirectory()`
```dart
static Future<Directory?> getPublicDCIMDirectory()
```
**Description:** Retrieves the DCIM (camera) directory.
**Platforms:** ✅ Android | ❌ iOS | ❌ Windows | ❌ macOS | ❌ Linux
**Example:**
```dart
final dcimDir = await PathProviderMaster.getPublicDCIMDirectory();
if (dcimDir != null) {
  final cameraPhoto = File('${dcimDir.path}/IMG_001.jpg');
}
```

---

## Practical Examples

### Save a File
```dart
Future<void> saveFile(String content) async {
  final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
  if (docsDir != null) {
    final file = File('${docsDir.path}/myfile.txt');
    await file.writeAsString(content);
    print('File saved: ${file.path}');
  }
}
```

### Save an Image to the Public Gallery
```dart
Future<void> saveImageToGallery(Uint8List imageBytes) async {
  final picturesDir = await PathProviderMaster.getPublicPicturesDirectory();
  if (picturesDir != null) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${picturesDir.path}/photo_$timestamp.jpg');
    await file.writeAsBytes(imageBytes);
    print('Image saved: ${file.path}');
  }
}
```

### Clear Cache
```dart
Future<void> clearCache() async {
  final tempDir = await PathProviderMaster.getTemporaryDirectory();
  if (tempDir != null && await tempDir.exists()) {
    await tempDir.delete(recursive: true);
    await tempDir.create();
    print('Cache cleared');
  }
}
```

### Calculate Directory Size
```dart
Future<int> calculateDirectorySize(Directory dir) async {
  int totalSize = 0;
  await for (var entity in dir.list(recursive: true)) {
    if (entity is File) {
      totalSize += await entity.length();
    }
  }
  return totalSize;
}
```

---

## Important Notes

1. **Null Check:** Always check the result for null, as some directories may not exist on all platforms.
2. **Permissions:** Request the necessary permissions to access external storage on Android.
3. **Directory Creation:** Ensure the directory exists before writing files:
   ```dart
   if (!await dir.exists()) {
     await dir.create(recursive: true);
   }
   ```
4. **Error Handling:** Always use try-catch to handle potential errors.