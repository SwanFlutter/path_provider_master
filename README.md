# Path Provider Master

A powerful Flutter plugin for accessing various system directories across all platforms (Android, iOS, Windows, macOS, Linux) with additional support for public directories.

[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-blue.svg)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 📑 Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Platform Support](#platform-support)
- [Usage](#usage)
- [API Reference with Examples](#api-reference-with-examples)
  - [Standard Methods](#standard-methods)
  - [Public Directory Methods](#public-directory-methods)
- [Complete Usage Example](#complete-usage-example)
- [Practical Examples](#practical-examples)
- [Permissions](#permissions)
- [Running the Example](#running-the-example)
- [Testing](#testing)
- [Important Notes](#important-notes)
- [📚 Documentation](#-documentation)
- [License](#license)

---

## Features

This plugin provides all the capabilities of `path_provider` plus additional public directory access:

### Standard Methods:
- ✅ `getTemporaryDirectory()` - Temporary directory
- ✅ `getApplicationSupportDirectory()` - Application support directory
- ✅ `getLibraryDirectory()` - Library directory (iOS/macOS)
- ✅ `getApplicationDocumentsDirectory()` - Application documents directory
- ✅ `getExternalStorageDirectory()` - External storage (Android)
- ✅ `getExternalCacheDirectories()` - External cache directories list
- ✅ `getExternalStorageDirectories()` - External storage directories list
- ✅ `getDownloadsDirectory()` - Downloads directory

### New Methods (Public Directories):
- 🆕 `getPublicPicturesDirectory()` - Public pictures directory
- 🆕 `getPublicVideosDirectory()` - Public videos directory
- 🆕 `getPublicMusicDirectory()` - Public music directory
- 🆕 `getPublicDownloadsDirectory()` - Public downloads directory
- 🆕 `getPublicDocumentsDirectory()` - Public documents directory
- 🆕 `getPublicDCIMDirectory()` - DCIM directory (Camera)

## Installation

### Requirements

- **Flutter**: >= 3.3.0
- **Dart**: >= 3.10.8
- **Android**: API 21+
- **iOS**: iOS 12+
- **Windows**: Windows 10+
- **macOS**: macOS 10.14+
- **Linux**: Ubuntu 20.04+
- **Web**: Chrome, Firefox, Safari, Edge

### Option 1: From GitHub (Recommended)

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  path_provider_master:
    git:
      url: https://github.com/SwanFlutter/path_provider_master.git
      ref: main
```

Then run:
```bash
flutter pub get
```

### Option 2: From Local Path

If you have the plugin locally:

```yaml
dependencies:
  path_provider_master:
    path: ../path_provider_master  # adjust path as needed
```

Then run:
```bash
flutter pub get
```

### Option 3: From pub.dev (When Published)

Once published to pub.dev:

```yaml
dependencies:
  path_provider_master: ^1.0.0
```

Then run:
```bash
flutter pub get
```

---

## Getting Started

### 1. Import the Package

```dart
import 'package:path_provider_master/path_provider_master.dart';
import 'dart:io';
```

### 2. Get a Directory Path

```dart
// Get application documents directory
final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
if (docsDir != null) {
  print('Documents: ${docsDir.path}');
}
```

### 3. Use the Path

```dart
// Save a file
final file = File('${docsDir.path}/myfile.txt');
await file.writeAsString('Hello, World!');

// Read the file
final content = await file.readAsString();
print(content);
```

### 4. Handle Platform Differences

```dart
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> example() async {
  if (kIsWeb) {
    // Web: Use virtual paths with IndexedDB/localStorage
    final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
    print(docsDir?.path); // /web_storage/documents
  } else {
    // Native: Use actual file system paths
    final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
    print(docsDir?.path); // /data/user/0/com.example.app/app_flutter/documents
  }
}
```

---

## Platform Support

| Method | Android | iOS | Windows | macOS | Linux | Web |
|--------|---------|-----|---------|-------|-------|-----|
| getTemporaryDirectory | ✅ | ✅ | ✅ | ✅ | ✅ | ✅* |
| getApplicationSupportDirectory | ✅ | ✅ | ✅ | ✅ | ✅ | ✅* |
| getLibraryDirectory | ❌ | ✅ | ❌ | ✅ | ❌ | ❌ |
| getApplicationDocumentsDirectory | ✅ | ✅ | ✅ | ✅ | ✅ | ✅* |
| getExternalStorageDirectory | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| getExternalCacheDirectories | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| getExternalStorageDirectories | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| getDownloadsDirectory | ✅ | ✅ | ✅ | ✅ | ✅ | ✅* |
| getPublicPicturesDirectory | ✅ | ✅ | ✅ | ✅ | ✅ | ✅* |
| getPublicVideosDirectory | ✅ | ✅ | ✅ | ✅ | ✅ | ✅* |
| getPublicMusicDirectory | ✅ | ✅ | ✅ | ✅ | ✅ | ✅* |
| getPublicDownloadsDirectory | ✅ | ✅ | ✅ | ✅ | ✅ | ✅* |
| getPublicDocumentsDirectory | ✅ | ✅ | ✅ | ✅ | ✅ | ✅* |
| getPublicDCIMDirectory | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |

**Note:** Methods marked with * on Web return virtual paths that map to browser storage APIs (IndexedDB, localStorage). See [Web Usage Guide](WEB_USAGE_GUIDE.md) for details.

---

## 🌐 Web Platform Support

Path Provider Master now supports web platforms! However, web has a different storage model:

### Key Points:
- ✅ **Virtual Paths**: All paths are virtual and map to browser storage APIs
- ✅ **IndexedDB**: Use for large binary data storage
- ✅ **localStorage**: Use for small text data
- ✅ **Browser Downloads**: Files are downloaded via browser API
- ⚠️ **Storage Limits**: Typically 50-100MB (varies by browser)
- ⚠️ **No Direct File System**: Access requires user permission

### Quick Web Example:

```dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider_master/path_provider_master.dart';

Future<void> webExample() async {
  if (kIsWeb) {
    // Get virtual path
    final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
    print(docsDir?.path); // Output: /web_storage/documents
    
    // Use with IndexedDB or localStorage for actual storage
    // See WEB_USAGE_GUIDE.md for complete examples
  }
}
```

### Web Resources:
- 📖 [Complete Web Usage Guide](WEB_USAGE_GUIDE.md)
- 💻 [Web Example App](example/lib/web_example.dart)
- 🔧 [Web Storage Helper](lib/path_provider_master_web.dart)

---

## Usage

### Import the package

```dart
import 'package:path_provider_master/path_provider_master.dart';
import 'dart:io';
```

---

## API Reference with Examples

### Standard Methods

All methods return `Future<Directory?>` or `Future<List<Directory>?>` for list methods.

#### 1. getTemporaryDirectory()

Get the temporary directory path. Files in this directory may be cleared by the system.

**Platforms:** Android, iOS, Windows, macOS, Linux

**Example:**
```dart
Future<void> saveTemporaryFile() async {
  final tempDir = await PathProviderMaster.getTemporaryDirectory();
  if (tempDir != null) {
    final file = File('${tempDir.path}/temp_cache.txt');
    await file.writeAsString('Temporary data');
    print('Temp file saved: ${file.path}');
  }
}
```

**Output Example:**
- Android: `/data/user/0/com.example.app/cache`
- iOS: `/var/mobile/Containers/Data/Application/.../tmp`
- Windows: `C:\Users\Username\AppData\Local\Temp`

---

#### 2. getApplicationSupportDirectory()

Get the application support directory. Suitable for storing app support files.

**Platforms:** Android, iOS, Windows, macOS, Linux

**Example:**
```dart
Future<void> saveAppData() async {
  final supportDir = await PathProviderMaster.getApplicationSupportDirectory();
  if (supportDir != null) {
    // Create directory if it doesn't exist
    if (!await supportDir.exists()) {
      await supportDir.create(recursive: true);
    }
    
    final dbFile = File('${supportDir.path}/app_database.db');
    await dbFile.writeAsString('Database content');
    print('Database saved: ${dbFile.path}');
  }
}
```

**Output Example:**
- Android: `/data/user/0/com.example.app/files`
- iOS: `/var/mobile/Containers/Data/Application/.../Library/Application Support`
- Windows: `C:\Users\Username\AppData\Roaming`

---

#### 3. getLibraryDirectory()

Get the Library directory (iOS/macOS only).

**Platforms:** iOS, macOS

**Example:**
```dart
Future<void> saveToLibrary() async {
  final libraryDir = await PathProviderMaster.getLibraryDirectory();
  if (libraryDir != null) {
    final file = File('${libraryDir.path}/preferences.plist');
    await file.writeAsString('<?xml version="1.0"?>...');
    print('Library file saved: ${file.path}');
  } else {
    print('Library directory not available on this platform');
  }
}
```

**Output Example:**
- iOS: `/var/mobile/Containers/Data/Application/.../Library`
- macOS: `/Users/username/Library`

---

#### 4. getApplicationDocumentsDirectory()

Get the application documents directory. Suitable for storing user files.

**Platforms:** Android, iOS, Windows, macOS, Linux

**Example:**
```dart
Future<void> saveUserDocument() async {
  final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
  if (docsDir != null) {
    final file = File('${docsDir.path}/user_notes.txt');
    await file.writeAsString('User notes content');
    print('Document saved: ${file.path}');
    
    // Read the file
    if (await file.exists()) {
      final content = await file.readAsString();
      print('Content: $content');
    }
  }
}
```

**Output Example:**
- Android: `/data/user/0/com.example.app/app_flutter/documents`
- iOS: `/var/mobile/Containers/Data/Application/.../Documents`
- Windows: `C:\Users\Username\Documents`

---

#### 5. getExternalStorageDirectory()

Get the external storage directory (Android only).

**Platforms:** Android

**Permissions Required:**
```xml
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

**Example:**
```dart
Future<void> saveToExternalStorage() async {
  final externalDir = await PathProviderMaster.getExternalStorageDirectory();
  if (externalDir != null) {
    final file = File('${externalDir.path}/exported_data.json');
    await file.writeAsString('{"data": "exported"}');
    print('External file saved: ${file.path}');
  } else {
    print('External storage not available');
  }
}
```

**Output Example:**
- Android: `/storage/emulated/0/Android/data/com.example.app/files`

---

#### 6. getExternalCacheDirectories()

Get a list of external cache directories (Android only).

**Platforms:** Android

**Example:**
```dart
Future<void> listExternalCaches() async {
  final cacheDirs = await PathProviderMaster.getExternalCacheDirectories();
  if (cacheDirs != null && cacheDirs.isNotEmpty) {
    print('Found ${cacheDirs.length} external cache directories:');
    for (int i = 0; i < cacheDirs.length; i++) {
      print('Cache $i: ${cacheDirs[i].path}');
      
      // Save cache file
      final cacheFile = File('${cacheDirs[i].path}/cache_$i.tmp');
      await cacheFile.writeAsString('Cache data $i');
    }
  } else {
    print('No external cache directories available');
  }
}
```

**Output Example:**
- Android: `[/storage/emulated/0/Android/data/com.example.app/cache, /storage/sdcard1/Android/data/com.example.app/cache]`

---

#### 7. getExternalStorageDirectories()

Get a list of external storage directories (Android only).

**Platforms:** Android

**Example:**
```dart
Future<void> listExternalStorages() async {
  final storageDirs = await PathProviderMaster.getExternalStorageDirectories();
  if (storageDirs != null && storageDirs.isNotEmpty) {
    print('Found ${storageDirs.length} external storage locations:');
    for (int i = 0; i < storageDirs.length; i++) {
      print('Storage $i: ${storageDirs[i].path}');
      
      // Check available space
      final stat = await storageDirs[i].stat();
      print('Type: ${stat.type}');
    }
  }
}
```

**Output Example:**
- Android: `[/storage/emulated/0/Android/data/com.example.app/files, /storage/sdcard1/Android/data/com.example.app/files]`

---

#### 8. getDownloadsDirectory()

Get the downloads directory path.

**Platforms:** Android, iOS, Windows, macOS, Linux

**Example:**
```dart
Future<void> downloadFile(List<int> fileBytes) async {
  final downloadsDir = await PathProviderMaster.getDownloadsDirectory();
  if (downloadsDir != null) {
    if (!await downloadsDir.exists()) {
      await downloadsDir.create(recursive: true);
    }
    
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${downloadsDir.path}/download_$timestamp.pdf');
    await file.writeAsBytes(fileBytes);
    print('File downloaded to: ${file.path}');
  }
}
```

**Output Example:**
- Android: `/storage/emulated/0/Android/data/com.example.app/files/Download`
- Windows: `C:\Users\Username\Downloads`
- macOS: `/Users/username/Downloads`

---

### Public Directory Methods

These methods provide access to shared/public directories where files can be accessed by other apps and users.

#### 9. getPublicPicturesDirectory()

Get the public pictures directory path.

**Platforms:** Android, iOS, Windows, macOS, Linux

**Example:**
```dart
import 'dart:typed_data';

Future<void> saveImageToGallery(Uint8List imageBytes) async {
  final picturesDir = await PathProviderMaster.getPublicPicturesDirectory();
  if (picturesDir != null) {
    if (!await picturesDir.exists()) {
      await picturesDir.create(recursive: true);
    }
    
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${picturesDir.path}/photo_$timestamp.jpg');
    await file.writeAsBytes(imageBytes);
    print('Image saved to gallery: ${file.path}');
  }
}
```

**Output Example:**
- Android: `/storage/emulated/0/Pictures`
- iOS: `/var/mobile/Media/DCIM`
- Windows: `C:\Users\Public\Pictures`

---

#### 10. getPublicVideosDirectory()

Get the public videos directory path.

**Platforms:** Android, iOS, Windows, macOS, Linux

**Example:**
```dart
Future<void> saveVideoToGallery(String videoPath) async {
  final videosDir = await PathProviderMaster.getPublicVideosDirectory();
  if (videosDir != null) {
    if (!await videosDir.exists()) {
      await videosDir.create(recursive: true);
    }
    
    final sourceFile = File(videoPath);
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final destFile = File('${videosDir.path}/video_$timestamp.mp4');
    
    await sourceFile.copy(destFile.path);
    print('Video saved: ${destFile.path}');
  }
}
```

**Output Example:**
- Android: `/storage/emulated/0/Movies`
- Windows: `C:\Users\Public\Videos`
- macOS: `/Users/username/Movies`

---

#### 11. getPublicMusicDirectory()

Get the public music directory path.

**Platforms:** Android, iOS, Windows, macOS, Linux

**Example:**
```dart
Future<void> saveAudioFile(List<int> audioBytes) async {
  final musicDir = await PathProviderMaster.getPublicMusicDirectory();
  if (musicDir != null) {
    if (!await musicDir.exists()) {
      await musicDir.create(recursive: true);
    }
    
    final file = File('${musicDir.path}/song.mp3');
    await file.writeAsBytes(audioBytes);
    print('Audio saved: ${file.path}');
  }
}
```

**Output Example:**
- Android: `/storage/emulated/0/Music`
- Windows: `C:\Users\Public\Music`
- macOS: `/Users/username/Music`

---

#### 12. getPublicDownloadsDirectory()

Get the public downloads directory path.

**Platforms:** Android, iOS, Windows, macOS, Linux

**Example:**
```dart
Future<void> saveToPublicDownloads(String fileName, String content) async {
  final downloadsDir = await PathProviderMaster.getPublicDownloadsDirectory();
  if (downloadsDir != null) {
    if (!await downloadsDir.exists()) {
      await downloadsDir.create(recursive: true);
    }
    
    final file = File('${downloadsDir.path}/$fileName');
    await file.writeAsString(content);
    print('File saved to public downloads: ${file.path}');
  }
}
```

**Output Example:**
- Android: `/storage/emulated/0/Download`
- Windows: `C:\Users\Public\Downloads`

---

#### 13. getPublicDocumentsDirectory()

Get the public documents directory path.

**Platforms:** Android, iOS, Windows, macOS, Linux

**Example:**
```dart
Future<void> exportDocument(String content) async {
  final docsDir = await PathProviderMaster.getPublicDocumentsDirectory();
  if (docsDir != null) {
    if (!await docsDir.exists()) {
      await docsDir.create(recursive: true);
    }
    
    final timestamp = DateTime.now().toIso8601String().split('T')[0];
    final file = File('${docsDir.path}/report_$timestamp.txt');
    await file.writeAsString(content);
    print('Document exported: ${file.path}');
  }
}
```

**Output Example:**
- Android: `/storage/emulated/0/Documents`
- Windows: `C:\Users\Public\Documents`
- macOS: `/Users/username/Documents`

---

#### 14. getPublicDCIMDirectory()

Get the DCIM (Camera) directory path (Android only).

**Platforms:** Android

**Example:**
```dart
Future<void> saveCameraPhoto(Uint8List photoBytes) async {
  final dcimDir = await PathProviderMaster.getPublicDCIMDirectory();
  if (dcimDir != null) {
    // Create Camera subfolder
    final cameraDir = Directory('${dcimDir.path}/Camera');
    if (!await cameraDir.exists()) {
      await cameraDir.create(recursive: true);
    }
    
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${cameraDir.path}/IMG_$timestamp.jpg');
    await file.writeAsBytes(photoBytes);
    print('Camera photo saved: ${file.path}');
  } else {
    print('DCIM directory not available on this platform');
  }
}
```

**Output Example:**
- Android: `/storage/emulated/0/DCIM`

---

## Complete Usage Example

```dart
import 'package:flutter/material.dart';
import 'package:path_provider_master/path_provider_master.dart';
import 'dart:io';

class PathProviderExample extends StatefulWidget {
  @override
  _PathProviderExampleState createState() => _PathProviderExampleState();
}

class _PathProviderExampleState extends State<PathProviderExample> {
  final Map<String, String?> _paths = {};

  @override
  void initState() {
    super.initState();
    _loadAllPaths();
  }

  Future<void> _loadAllPaths() async {
    // Get all directory paths
    final tempDir = await PathProviderMaster.getTemporaryDirectory();
    final supportDir = await PathProviderMaster.getApplicationSupportDirectory();
    final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
    final downloadsDir = await PathProviderMaster.getDownloadsDirectory();
    final picturesDir = await PathProviderMaster.getPublicPicturesDirectory();
    final videosDir = await PathProviderMaster.getPublicVideosDirectory();
    final musicDir = await PathProviderMaster.getPublicMusicDirectory();

    setState(() {
      _paths['Temporary'] = tempDir?.path;
      _paths['App Support'] = supportDir?.path;
      _paths['Documents'] = docsDir?.path;
      _paths['Downloads'] = downloadsDir?.path;
      _paths['Pictures'] = picturesDir?.path;
      _paths['Videos'] = videosDir?.path;
      _paths['Music'] = musicDir?.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Path Provider Master')),
      body: ListView.builder(
        itemCount: _paths.length,
        itemBuilder: (context, index) {
          final entry = _paths.entries.elementAt(index);
          return ListTile(
            title: Text(entry.key),
            subtitle: Text(entry.value ?? 'Not available'),
          );
        },
      ),
    );
  }
}
```

---

## Practical Examples

### Example 1: Save and Read User Data

```dart
class UserDataManager {
  static Future<void> saveUserData(Map<String, dynamic> data) async {
    final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
    if (docsDir != null) {
      final file = File('${docsDir.path}/user_data.json');
      await file.writeAsString(jsonEncode(data));
    }
  }

  static Future<Map<String, dynamic>?> loadUserData() async {
    final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
    if (docsDir != null) {
      final file = File('${docsDir.path}/user_data.json');
      if (await file.exists()) {
        final content = await file.readAsString();
        return jsonDecode(content);
      }
    }
    return null;
  }
}
```

### Example 2: Clear Cache

```dart
Future<void> clearAppCache() async {
  final tempDir = await PathProviderMaster.getTemporaryDirectory();
  if (tempDir != null && await tempDir.exists()) {
    final files = tempDir.listSync();
    for (var file in files) {
      try {
        if (file is File) {
          await file.delete();
        } else if (file is Directory) {
          await file.delete(recursive: true);
        }
      } catch (e) {
        print('Error deleting ${file.path}: $e');
      }
    }
    print('Cache cleared successfully');
  }
}
```

### Example 3: Calculate Directory Size

```dart
Future<int> getDirectorySize(Directory dir) async {
  int totalSize = 0;
  
  if (await dir.exists()) {
    await for (var entity in dir.list(recursive: true, followLinks: false)) {
      if (entity is File) {
        try {
          totalSize += await entity.length();
        } catch (e) {
          print('Error reading file size: $e');
        }
      }
    }
  }
  
  return totalSize;
}

String formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
  if (bytes < 1024 * 1024 * 1024) {
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }
  return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
}

// Usage
final tempDir = await PathProviderMaster.getTemporaryDirectory();
if (tempDir != null) {
  final size = await getDirectorySize(tempDir);
  print('Temp directory size: ${formatBytes(size)}');
}
```

---

## Permissions

### Android

Add to `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

<!-- For Android 13+ -->
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>
<uses-permission android:name="android.permission.READ_MEDIA_AUDIO"/>
```

### iOS

Add to `Info.plist`:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to photo library</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>This app needs to save photos to library</string>
```

### macOS

Configure entitlements in `macos/Runner/DebugProfile.entitlements`:

```xml
<key>com.apple.security.files.user-selected.read-write</key>
<true/>
<key>com.apple.security.files.downloads.read-write</key>
<true/>
```

---

## Running the Example

```bash
cd example
flutter run
```

## Testing

```bash
# Run unit tests
flutter test

# Run integration tests
cd example
flutter test integration_test/
```

---

## Important Notes

1. **Always check for null**: Some directories may not be available on all platforms
2. **Create directories**: Ensure the directory exists before writing files
3. **Handle errors**: Use try-catch blocks for file operations
4. **Request permissions**: Request necessary permissions on Android/iOS

```dart
// Good practice
final dir = await PathProviderMaster.getPublicPicturesDirectory();
if (dir != null) {
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }
  // Now safe to write files
}
```

---

## 🆘 Need Help?

### Common Issues

**Q: Method returns `null` on my platform**
- Check the [Platform Support](#platform-support) table to see if the method is supported
- Some methods are platform-specific (e.g., `getLibraryDirectory()` only works on iOS/macOS)

**Q: Permission denied errors**
- See the [Permissions Guide](PERMISSIONS_GUIDE.md) for platform-specific setup
- Make sure you've requested runtime permissions on Android 6.0+

**Q: Directory doesn't exist**
- Always create the directory before writing files:
```dart
if (!await dir.exists()) {
  await dir.create(recursive: true);
}
```

**Q: How to choose the right directory?**
- **User files**: Use `getApplicationDocumentsDirectory()`
- **Cache/temp files**: Use `getTemporaryDirectory()`
- **Shared media**: Use `getPublic*Directory()` methods
- **App data**: Use `getApplicationSupportDirectory()`

**Q: How to use on web?**
- Use `kIsWeb` to detect web platform
- Paths are virtual (`/web_storage/*`)
- Use IndexedDB or localStorage for actual storage
- See [Web Usage Guide](WEB_USAGE_GUIDE.md) for complete examples

### Installation Issues

**Q: `flutter pub get` fails**
```bash
# Clear pub cache
flutter pub cache clean

# Get dependencies again
flutter pub get
```

**Q: Plugin not found**
```bash
# Make sure you're in the correct directory
cd your_flutter_project

# Try again
flutter pub get
```

**Q: Build errors on Windows/Linux**
```bash
# Clean build
flutter clean

# Rebuild
flutter pub get
flutter build windows  # or flutter build linux
```

### Getting Support

- 📖 Read the [API Documentation](API_DOCUMENTATION.md)
- 🔐 Check [Permissions Guide](PERMISSIONS_GUIDE.md)
- 🌐 See [Web Usage Guide](WEB_USAGE_GUIDE.md)
- 💡 See [example/lib/usage_example.dart](example/lib/usage_example.dart) for practical examples
- 🐛 Report issues on [GitHub](https://github.com/SwanFlutter/path_provider_master/issues)

---

## 📚 Documentation

### Complete Guides

#### 📖 [API Documentation](API_DOCUMENTATION.md)
Complete API reference with detailed documentation for all methods, including:
- Method signatures and return types
- Platform availability for each method
- Detailed usage examples
- Best practices and tips
- Error handling guidelines

**Perfect for:** Developers who need detailed technical documentation

---

#### 🔐 [Permissions Guide](PERMISSIONS_GUIDE.md)
Comprehensive guide for setting up permissions across all platforms:
- **Android**: Manifest permissions, runtime permissions, Scoped Storage
- **iOS**: Info.plist configurations, photo library access
- **macOS**: Entitlements setup, sandbox configuration
- **Windows & Linux**: File system access configuration
- Complete code examples for requesting permissions
- Permission handling best practices

**Perfect for:** Setting up your app to access public directories

---

#### 🌐 [Web Usage Guide](WEB_USAGE_GUIDE.md)
Complete guide for using the plugin on web platforms:
- **Virtual Paths**: Understanding web storage model
- **IndexedDB**: Storing large binary data
- **localStorage**: Storing small text data
- **File Downloads**: Using browser download API
- **Storage Quotas**: Managing browser storage limits
- **Complete Examples**: Real-world web implementations

**Perfect for:** Developers building web applications

---

#### 🚀 [Quick Start Guide (Persian)](QUICK_START_FA.md)
راهنمای سریع فارسی شامل:
- نصب و راه‌اندازی
- مثال‌های ساده و کاربردی
- جدول کامل متدها
- نکات مهم

**Perfect for:** Persian-speaking developers who want a quick start

---

#### 🛠️ [Implementation Summary](IMPLEMENTATION_SUMMARY.md)
Technical implementation details including:
- Complete list of implemented files
- Native code structure (Android, iOS, Windows, macOS, Linux)
- Architecture overview
- Testing information

**Perfect for:** Contributors and developers who want to understand the plugin internals

---

### Quick Links

| Resource | Description | Language |
|----------|-------------|----------|
| [API_DOCUMENTATION.md](API_DOCUMENTATION.md) | Complete API reference with all methods | English & Persian |
| [PERMISSIONS_GUIDE.md](PERMISSIONS_GUIDE.md) | Platform-specific permission setup | English & Persian |
| [WEB_USAGE_GUIDE.md](WEB_USAGE_GUIDE.md) | Web platform usage and storage guide | English |
| [QUICK_START_FA.md](QUICK_START_FA.md) | Quick start guide | Persian |
| [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) | Technical implementation details | Persian |
| [example/lib/main.dart](example/lib/main.dart) | Full UI example with all methods | Dart |
| [example/lib/web_example.dart](example/lib/web_example.dart) | Web-specific example | Dart |
| [example/lib/usage_example.dart](example/lib/usage_example.dart) | Practical usage examples | Dart |

---

## 🆘 Need Help?

### Common Issues

**Q: Method returns `null` on my platform**
- Check the [Platform Support](#platform-support) table to see if the method is supported
- Some methods are platform-specific (e.g., `getLibraryDirectory()` only works on iOS/macOS)

**Q: Permission denied errors**
- See the [Permissions Guide](PERMISSIONS_GUIDE.md) for platform-specific setup
- Make sure you've requested runtime permissions on Android 6.0+

**Q: Directory doesn't exist**
- Always create the directory before writing files:
```dart
if (!await dir.exists()) {
  await dir.create(recursive: true);
}
```

**Q: How to choose the right directory?**
- **User files**: Use `getApplicationDocumentsDirectory()`
- **Cache/temp files**: Use `getTemporaryDirectory()`
- **Shared media**: Use `getPublic*Directory()` methods
- **App data**: Use `getApplicationSupportDirectory()`

### Getting Support

- 📖 Read the [API Documentation](API_DOCUMENTATION.md)
- 🔐 Check [Permissions Guide](PERMISSIONS_GUIDE.md)
- 💡 See [example/lib/usage_example.dart](example/lib/usage_example.dart) for practical examples
- 🐛 Report issues on GitHub

---




---

## License

MIT License - See [LICENSE](LICENSE) file for details

---

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### How to Contribute

1. **Fork the repository**
   ```bash
   git clone https://github.com/SwanFlutter/path_provider_master.git
   cd path_provider_master
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the existing code style
   - Add tests for new features
   - Update documentation

4. **Test your changes**
   ```bash
   flutter test
   flutter test integration_test/
   ```

5. **Commit and push**
   ```bash
   git add .
   git commit -m "Add your feature description"
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Describe your changes clearly
   - Reference any related issues

### Development Setup

```bash
# Clone the repository
git clone https://github.com/SwanFlutter/path_provider_master.git
cd path_provider_master

# Get dependencies
flutter pub get

# Run tests
flutter test

# Run example app
cd example
flutter run
```

### Code Style

- Follow Dart conventions
- Use meaningful variable names
- Add comments for complex logic
- Format code with `dart format`

```bash
dart format lib/ test/ example/lib/
```

### Reporting Issues

When reporting issues, please include:
- Flutter version (`flutter --version`)
- Platform and OS version
- Minimal code to reproduce
- Expected vs actual behavior

---

## 📞 Contact & Support

- **GitHub**: [SwanFlutter/path_provider_master](https://github.com/SwanFlutter/path_provider_master)
- **Issues**: [Report a bug](https://github.com/SwanFlutter/path_provider_master/issues)
- **Discussions**: [Ask a question](https://github.com/SwanFlutter/path_provider_master/discussions)

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes in each release.

---

## Acknowledgments

This plugin provides comprehensive path access across all Flutter platforms, inspired by the official `path_provider` package with additional public directory support.

---

**Made with ❤️ by [SwanFlutter](https://github.com/SwanFlutter)**
