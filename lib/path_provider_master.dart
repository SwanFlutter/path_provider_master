import 'dart:io';

import 'path_provider_master_platform_interface.dart';

/// A utility class for accessing common platform-specific file system paths.
///
/// This class provides methods to get paths to various directories such as
/// temporary files, application support, documents, downloads, and public directories.
///
/// Example usage:
/// ```dart
/// // Get temporary directory
/// final tempDir = await PathProviderMaster.getTemporaryDirectory();
/// if (tempDir != null) {
///   final tempFile = File('${tempDir.path}/temp.txt');
///   await tempFile.writeAsString('Temporary data');
/// }
///
/// // Get application documents directory
/// final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
/// if (docsDir != null) {
///   final appFile = File('${docsDir.path}/app_data.json');
///   await appFile.writeAsString('{"user": "data"}');
/// }
///
/// // Get public pictures directory (platform-specific)
/// final picturesDir = await PathProviderMaster.getPublicPicturesDirectory();
/// if (picturesDir != null) {
///   final imageFile = File('${picturesDir.path}/photo.jpg');
///   // Save image to public pictures
/// }
/// ```
class PathProviderMaster {
  /// Get temporary directory path
  /// Files in this directory may be deleted by the system
  ///
  /// Example:
  /// ```dart
  /// final tempDir = await PathProviderMaster.getTemporaryDirectory();
  /// if (tempDir != null) {
  ///   // Create temporary files for processing
  ///   final tempFile = File('${tempDir.path}/temp_image_${DateTime.now().millisecondsSinceEpoch}.jpg');
  ///
  ///   // Download and process temporary data
  ///   final response = await http.get(Uri.parse('https://example.com/image.jpg'));
  ///   await tempFile.writeAsBytes(response.bodyBytes);
  ///
  ///   // Process the file and then delete it
  ///   // ... process tempFile ...
  ///   await tempFile.delete();
  /// }
  /// ```
  static Future<Directory?> getTemporaryDirectory() async {
    final path = await PathProviderMasterPlatform.instance
        .getTemporaryDirectory();
    return path != null ? Directory(path) : null;
  }

  /// Get application support directory path
  /// Suitable for storing support files
  ///
  /// Example:
  /// ```dart
  /// final supportDir = await PathProviderMaster.getApplicationSupportDirectory();
  /// if (supportDir != null) {
  ///   // Store app support files like databases, configuration files
  ///   final configFile = File('${supportDir.path}/app_config.json');
  ///   await configFile.writeAsString('{"theme": "dark", "language": "en"}');
  ///
  ///   // Create a subdirectory for organized storage
  ///   final databaseDir = Directory('${supportDir.path}/databases');
  ///   if (!await databaseDir.exists()) {
  ///     await databaseDir.create(recursive: true);
  ///   }
  /// }
  /// ```
  static Future<Directory?> getApplicationSupportDirectory() async {
    final path = await PathProviderMasterPlatform.instance
        .getApplicationSupportDirectory();
    return path != null ? Directory(path) : null;
  }

  /// Get Library directory path (iOS specific)
  ///
  /// Example:
  /// ```dart
  /// final libraryDir = await PathProviderMaster.getLibraryDirectory();
  /// if (libraryDir != null) {
  ///   // Store iOS-specific library files
  ///   final prefsFile = File('${libraryDir.path}/Preferences/app_prefs.plist');
  ///
  ///   // Create directory for cached data
  ///   final cacheDir = Directory('${libraryDir.path}/Caches');
  ///   if (!await cacheDir.exists()) {
  ///     await cacheDir.create(recursive: true);
  ///   }
  ///
  ///   // Note: This directory is persistent across app launches
  ///   final settingsFile = File('${libraryDir.path}/settings.json');
  ///   await settingsFile.writeAsString('{"user_preferences": {}}');
  /// }
  /// ```
  static Future<Directory?> getLibraryDirectory() async {
    final path = await PathProviderMasterPlatform.instance
        .getLibraryDirectory();
    return path != null ? Directory(path) : null;
  }

  /// Get application documents directory path
  /// Suitable for storing user files
  ///
  /// Example:
  /// ```dart
  /// final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
  /// if (docsDir != null) {
  ///   // Store user documents and important data
  ///   final userDoc = File('${docsDir.path}/user_document.txt');
  ///   await userDoc.writeAsString('Important user information');
  ///
  ///   // Create organized subdirectories
  ///   final reportsDir = Directory('${docsDir.path}/Reports');
  ///   if (!await reportsDir.exists()) {
  ///     await reportsDir.create(recursive: true);
  ///   }
  ///
  ///   // Store user-generated content
  ///   final exportFile = File('${docsDir.path}/export_${DateTime.now().toIso8601String()}.csv');
  ///   await exportFile.writeAsString('Name,Age,Email\nJohn,30,john@example.com');
  /// }
  /// ```
  static Future<Directory?> getApplicationDocumentsDirectory() async {
    final path = await PathProviderMasterPlatform.instance
        .getApplicationDocumentsDirectory();
    return path != null ? Directory(path) : null;
  }

  /// Get external storage path (Android specific)
  ///
  /// Example:
  /// ```dart
  /// final externalDir = await PathProviderMaster.getExternalStorageDirectory();
  /// if (externalDir != null) {
  ///   // Store large files on external storage
  ///   final largeFile = File('${externalDir.path}/large_dataset.json');
  ///   await largeFile.writeAsString('{"large": "data"}');
  ///
  ///   // Create app-specific directory on external storage
  ///   final appDir = Directory('${externalDir.path}/MyApp');
  ///   if (!await appDir.exists()) {
  ///     await appDir.create(recursive: true);
  ///   }
  ///
  ///   // Note: Requires storage permissions on Android
  ///   // Add to AndroidManifest.xml: <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
  /// }
  /// ```
  static Future<Directory?> getExternalStorageDirectory() async {
    final path = await PathProviderMasterPlatform.instance
        .getExternalStorageDirectory();
    return path != null ? Directory(path) : null;
  }

  /// Get list of external cache directories
  ///
  /// Example:
  /// ```dart
  /// final cacheDirs = await PathProviderMaster.getExternalCacheDirectories();
  /// if (cacheDirs != null && cacheDirs.isNotEmpty) {
  ///   // Use the first available cache directory
  ///   final primaryCacheDir = cacheDirs.first;
  ///
  ///   // Store cached images
  ///   final imageCacheDir = Directory('${primaryCacheDir.path}/images');
  ///   if (!await imageCacheDir.exists()) {
  ///     await imageCacheDir.create(recursive: true);
  ///   }
  ///
  ///   // Store multiple cache files
  ///   for (var i = 0; i < cacheDirs.length; i++) {
  ///     final cacheFile = File('${cacheDirs[i].path}/cache_data_$i.tmp');
  ///     await cacheFile.writeAsString('Cache data for directory $i');
  ///   }
  ///
  ///   // Note: These directories may be cleared by the system when storage is low
  /// }
  /// ```
  static Future<List<Directory>?> getExternalCacheDirectories() async {
    final paths = await PathProviderMasterPlatform.instance
        .getExternalCacheDirectories();
    return paths?.map((path) => Directory(path)).toList();
  }

  /// Get list of external storage paths
  ///
  /// Example:
  /// ```dart
  /// final storageDirs = await PathProviderMaster.getExternalStorageDirectories();
  /// if (storageDirs != null && storageDirs.isNotEmpty) {
  ///   // Check available storage locations
  ///   for (var dir in storageDirs) {
  ///     print('Available storage: ${dir.path}');
  ///   }
  ///
  ///   // Use primary external storage
  ///   final primaryStorage = storageDirs.first;
  ///   final dataFile = File('${primaryStorage.path}/important_data.json');
  ///   await dataFile.writeAsString('{"key": "value"}');
  ///
  ///   // Distribute files across multiple storage locations
  ///   if (storageDirs.length > 1) {
  ///     final backupStorage = storageDirs.last;
  ///     final backupFile = File('${backupStorage.path}/backup_data.json');
  ///     await backupFile.writeAsString('{"backup": true}');
  ///   }
  /// }
  /// ```
  static Future<List<Directory>?> getExternalStorageDirectories() async {
    final paths = await PathProviderMasterPlatform.instance
        .getExternalStorageDirectories();
    return paths?.map((path) => Directory(path)).toList();
  }

  /// Get Downloads directory path
  ///
  /// Example:
  /// ```dart
  /// final downloadsDir = await PathProviderMaster.getDownloadsDirectory();
  /// if (downloadsDir != null) {
  ///   // Save downloadable content that users can access
  ///   final reportFile = File('${downloadsDir.path}/monthly_report.pdf');
  ///   await reportFile.writeAsBytes(pdfBytes); // Assuming pdfBytes contains PDF data
  ///
  ///   // Create user-accessible exports
  ///   final exportFile = File('${downloadsDir.path}/data_export_${DateTime.now().toIso8601String()}.csv');
  ///   await exportFile.writeAsString('Name,Email,Date\nJohn,john@example.com,2024-01-01');
  ///
  ///   // Show notification to user that file is available
  ///   print('File saved to: ${exportFile.path}');
  ///
  ///   // Note: Files here persist and are accessible to users through file managers
  /// }
  /// ```
  static Future<Directory?> getDownloadsDirectory() async {
    final path = await PathProviderMasterPlatform.instance
        .getDownloadsDirectory();
    return path != null ? Directory(path) : null;
  }

  // New methods for public paths

  /// Get public pictures directory path
  static Future<Directory?> getPublicPicturesDirectory() async {
    final path = await PathProviderMasterPlatform.instance
        .getPublicPicturesDirectory();
    return path != null ? Directory(path) : null;
  }

  /// Get public videos directory path
  static Future<Directory?> getPublicVideosDirectory() async {
    final path = await PathProviderMasterPlatform.instance
        .getPublicVideosDirectory();
    return path != null ? Directory(path) : null;
  }

  /// Get public music directory path
  static Future<Directory?> getPublicMusicDirectory() async {
    final path = await PathProviderMasterPlatform.instance
        .getPublicMusicDirectory();
    return path != null ? Directory(path) : null;
  }

  /// Get public downloads directory path
  static Future<Directory?> getPublicDownloadsDirectory() async {
    final path = await PathProviderMasterPlatform.instance
        .getPublicDownloadsDirectory();
    return path != null ? Directory(path) : null;
  }

  /// Get public documents directory path
  static Future<Directory?> getPublicDocumentsDirectory() async {
    final path = await PathProviderMasterPlatform.instance
        .getPublicDocumentsDirectory();
    return path != null ? Directory(path) : null;
  }

  /// Get public DCIM directory path (camera)
  static Future<Directory?> getPublicDCIMDirectory() async {
    final path = await PathProviderMasterPlatform.instance
        .getPublicDCIMDirectory();
    return path != null ? Directory(path) : null;
  }
}
