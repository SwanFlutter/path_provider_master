# Web Platform Usage Guide - Path Provider Master

## Overview

The Path Provider Master plugin works on web platforms, but with important differences from native platforms. This guide explains how to use the plugin effectively on web.

## Key Differences on Web

### 1. Virtual Paths
All paths returned on web are **virtual paths** that map to browser storage APIs:

```dart
final tempDir = await PathProviderMaster.getTemporaryDirectory();
print(tempDir?.path); // Output: /web_storage/temp
```

These paths don't represent actual file system locations. They're identifiers for browser storage.

### 2. Storage Limitations
- **Quota**: Typically 50-100MB (varies by browser)
- **Persistence**: May be cleared by browser
- **No direct file system access** without user permission

### 3. Available Methods

| Method | Available | Maps To |
|--------|-----------|---------|
| getTemporaryDirectory() | ✅ | sessionStorage / IndexedDB |
| getApplicationSupportDirectory() | ✅ | IndexedDB |
| getApplicationDocumentsDirectory() | ✅ | IndexedDB |
| getDownloadsDirectory() | ✅ | Browser download API |
| getPublicPicturesDirectory() | ✅ | Virtual path |
| getPublicVideosDirectory() | ✅ | Virtual path |
| getPublicMusicDirectory() | ✅ | Virtual path |
| getPublicDownloadsDirectory() | ✅ | Browser download API |
| getPublicDocumentsDirectory() | ✅ | Virtual path |
| getLibraryDirectory() | ❌ | Not available |
| getExternalStorageDirectory() | ❌ | Not available |
| getExternalCacheDirectories() | ❌ | Not available |
| getExternalStorageDirectories() | ❌ | Not available |
| getPublicDCIMDirectory() | ❌ | Not available |

## Usage Examples

### 1. Basic Path Access

```dart
import 'package:path_provider_master/path_provider_master.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> getWebPaths() async {
  if (kIsWeb) {
    final tempDir = await PathProviderMaster.getTemporaryDirectory();
    print('Temp: ${tempDir?.path}'); // /web_storage/temp
    
    final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
    print('Docs: ${docsDir?.path}'); // /web_storage/documents
  }
}
```

### 2. Storing Data with IndexedDB

Since paths are virtual, you need to use browser storage APIs:

```dart
import 'dart:html' as html;
import 'dart:convert';

class WebStorageManager {
  static const String _dbName = 'path_provider_master_db';
  static const String _storeName = 'files';

  /// Save data to IndexedDB
  static Future<void> saveData(String key, String data) async {
    final db = await html.window.indexedDB!.open(_dbName, version: 1,
      onUpgradeNeeded: (e) {
        final db = e.target.result as html.Database;
        if (!db.objectStoreNames!.contains(_storeName)) {
          db.createObjectStore(_storeName);
        }
      },
    );

    final transaction = db.transaction(_storeName, 'readwrite');
    final store = transaction.objectStore(_storeName);
    await store.put(data, key);
    await transaction.completed;
    db.close();
  }

  /// Load data from IndexedDB
  static Future<String?> loadData(String key) async {
    final db = await html.window.indexedDB!.open(_dbName, version: 1);
    final transaction = db.transaction(_storeName, 'readonly');
    final store = transaction.objectStore(_storeName);
    final result = await store.getObject(key);
    db.close();
    return result as String?;
  }

  /// Delete data from IndexedDB
  static Future<void> deleteData(String key) async {
    final db = await html.window.indexedDB!.open(_dbName, version: 1);
    final transaction = db.transaction(_storeName, 'readwrite');
    final store = transaction.objectStore(_storeName);
    await store.delete(key);
    await transaction.completed;
    db.close();
  }
}

// Usage
Future<void> example() async {
  final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
  if (docsDir != null) {
    // Use the path as a namespace/identifier
    final key = '${docsDir.path}/myfile.txt';
    await WebStorageManager.saveData(key, 'Hello, Web!');
    
    final data = await WebStorageManager.loadData(key);
    print('Loaded: $data');
  }
}
```

### 3. Downloading Files

For downloads, use the browser's download mechanism:

```dart
import 'dart:html' as html;
import 'dart:typed_data';

class WebDownloader {
  /// Download text file
  static void downloadTextFile(String filename, String content) {
    final blob = html.Blob([content], 'text/plain');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  /// Download binary file
  static void downloadBinaryFile(String filename, Uint8List bytes) {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  /// Download JSON file
  static void downloadJsonFile(String filename, Map<String, dynamic> data) {
    final jsonString = jsonEncode(data);
    downloadTextFile(filename, jsonString);
  }
}

// Usage with Path Provider Master
Future<void> downloadExample() async {
  final downloadsDir = await PathProviderMaster.getDownloadsDirectory();
  if (downloadsDir != null) {
    // The path is virtual, but we can use it as a reference
    print('Downloads will be saved via browser: ${downloadsDir.path}');
    
    // Trigger browser download
    WebDownloader.downloadTextFile('example.txt', 'Hello from web!');
  }
}
```

### 4. Using localStorage for Small Data

```dart
import 'dart:html' as html;

class WebLocalStorage {
  /// Save to localStorage
  static void save(String key, String value) {
    html.window.localStorage[key] = value;
  }

  /// Load from localStorage
  static String? load(String key) {
    return html.window.localStorage[key];
  }

  /// Remove from localStorage
  static void remove(String key) {
    html.window.localStorage.remove(key);
  }

  /// Clear all localStorage
  static void clear() {
    html.window.localStorage.clear();
  }
}

// Usage
Future<void> localStorageExample() async {
  final supportDir = await PathProviderMaster.getApplicationSupportDirectory();
  if (supportDir != null) {
    final key = '${supportDir.path}/settings';
    WebLocalStorage.save(key, 'user_settings_data');
    
    final data = WebLocalStorage.load(key);
    print('Settings: $data');
  }
}
```

### 5. File System Access API (Modern Browsers)

For modern browsers, you can request direct file system access:

```dart
import 'dart:html' as html;

class WebFileSystemAccess {
  /// Request file picker
  static Future<html.File?> pickFile() async {
    final input = html.FileUploadInputElement()..accept = '*/*';
    input.click();
    
    await input.onChange.first;
    if (input.files!.isEmpty) return null;
    
    return input.files!.first;
  }

  /// Read file content
  static Future<String> readFileAsText(html.File file) async {
    final reader = html.FileReader();
    reader.readAsText(file);
    await reader.onLoad.first;
    return reader.result as String;
  }

  /// Read file as bytes
  static Future<Uint8List> readFileAsBytes(html.File file) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoad.first;
    return Uint8List.view(reader.result as ByteBuffer);
  }
}

// Usage
Future<void> fileSystemExample() async {
  final file = await WebFileSystemAccess.pickFile();
  if (file != null) {
    final content = await WebFileSystemAccess.readFileAsText(file);
    print('File content: $content');
    
    // Save to IndexedDB using path as key
    final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
    if (docsDir != null) {
      final key = '${docsDir.path}/${file.name}';
      await WebStorageManager.saveData(key, content);
    }
  }
}
```

### 6. Storage Quota Management

```dart
import 'dart:html' as html;

class WebStorageQuota {
  /// Get storage estimate
  static Future<Map<String, dynamic>?> getEstimate() async {
    try {
      final storage = html.window.navigator.storage;
      if (storage != null) {
        final estimate = await storage.estimate();
        return {
          'usage': estimate.usage,
          'quota': estimate.quota,
          'usagePercent': estimate.quota != null && estimate.quota! > 0
              ? (estimate.usage! / estimate.quota! * 100).toStringAsFixed(2)
              : '0',
          'usageMB': (estimate.usage! / (1024 * 1024)).toStringAsFixed(2),
          'quotaMB': (estimate.quota! / (1024 * 1024)).toStringAsFixed(2),
        };
      }
    } catch (e) {
      print('Error getting storage estimate: $e');
    }
    return null;
  }

  /// Request persistent storage
  static Future<bool> requestPersistent() async {
    try {
      final storage = html.window.navigator.storage;
      if (storage != null) {
        return await storage.persist();
      }
    } catch (e) {
      print('Error requesting persistent storage: $e');
    }
    return false;
  }

  /// Check if storage is persistent
  static Future<bool> isPersistent() async {
    try {
      final storage = html.window.navigator.storage;
      if (storage != null) {
        return await storage.persisted();
      }
    } catch (e) {
      print('Error checking persistent storage: $e');
    }
    return false;
  }
}

// Usage
Future<void> quotaExample() async {
  final estimate = await WebStorageQuota.getEstimate();
  if (estimate != null) {
    print('Storage usage: ${estimate['usageMB']} MB / ${estimate['quotaMB']} MB');
    print('Usage: ${estimate['usagePercent']}%');
  }

  final isPersistent = await WebStorageQuota.isPersistent();
  print('Storage is persistent: $isPersistent');

  if (!isPersistent) {
    final granted = await WebStorageQuota.requestPersistent();
    print('Persistent storage granted: $granted');
  }
}
```

## Complete Web Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider_master/path_provider_master.dart';
import 'dart:html' as html;

class WebFileManager {
  /// Save text file on web
  static Future<void> saveTextFile(String content) async {
    if (!kIsWeb) return;

    final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
    if (docsDir != null) {
      // Use IndexedDB for storage
      final key = '${docsDir.path}/myfile.txt';
      await WebStorageManager.saveData(key, content);
      print('File saved to: $key');
    }
  }

  /// Load text file on web
  static Future<String?> loadTextFile() async {
    if (!kIsWeb) return null;

    final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
    if (docsDir != null) {
      final key = '${docsDir.path}/myfile.txt';
      return await WebStorageManager.loadData(key);
    }
    return null;
  }

  /// Download file to user's computer
  static void downloadFile(String filename, String content) {
    if (!kIsWeb) return;

    final blob = html.Blob([content], 'text/plain');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
```

## Best Practices for Web

1. **Always check platform**: Use `kIsWeb` to detect web platform
2. **Use appropriate storage**: IndexedDB for large data, localStorage for small data
3. **Handle quotas**: Monitor storage usage and request persistent storage
4. **Provide downloads**: Use browser download API for file exports
5. **Clear old data**: Implement cleanup to avoid quota issues
6. **Test across browsers**: Different browsers have different limits

## Browser Compatibility

| Feature | Chrome | Firefox | Safari | Edge |
|---------|--------|---------|--------|------|
| IndexedDB | ✅ | ✅ | ✅ | ✅ |
| localStorage | ✅ | ✅ | ✅ | ✅ |
| Storage API | ✅ | ✅ | ✅ | ✅ |
| File System Access | ✅ | ❌ | ❌ | ✅ |

## Limitations

1. **No direct file system access** without user interaction
2. **Storage quotas** limit data size
3. **Data may be cleared** by browser
4. **No background sync** without service workers
5. **CORS restrictions** for cross-origin requests

## Additional Resources

- [IndexedDB API](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API)
- [File System Access API](https://developer.mozilla.org/en-US/docs/Web/API/File_System_Access_API)
- [Storage API](https://developer.mozilla.org/en-US/docs/Web/API/Storage_API)
- [Web Storage API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Storage_API)
