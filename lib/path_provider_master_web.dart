// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'path_provider_master_platform_interface.dart';

/// A web implementation of the PathProviderMasterPlatform of the PathProviderMaster plugin.
///
/// Web platform uses browser storage APIs:
/// - IndexedDB for temporary storage
/// - localStorage for persistent storage
/// - File System Access API (when available)
///
/// Note: Web browsers have storage limitations and different security models.
/// Most directories return virtual paths that map to browser storage.
class PathProviderMasterWeb extends PathProviderMasterPlatform {
  /// Constructs a PathProviderMasterWeb
  PathProviderMasterWeb();

  static void registerWith(Registrar registrar) {
    PathProviderMasterPlatform.instance = PathProviderMasterWeb();
  }

  /// Base path for web storage (virtual path)
  static const String _webStorageBasePath = '/web_storage';

  @override
  Future<String?> getTemporaryDirectory() async {
    // Web temporary storage - maps to IndexedDB or sessionStorage
    // This is cleared when the browser session ends
    return '$_webStorageBasePath/temp';
  }

  @override
  Future<String?> getApplicationSupportDirectory() async {
    // Web application support - maps to IndexedDB
    // Persistent storage for app data
    return '$_webStorageBasePath/app_support';
  }

  @override
  Future<String?> getLibraryDirectory() async {
    // Web doesn't have a library directory concept
    // Return null to indicate not available
    return null;
  }

  @override
  Future<String?> getApplicationDocumentsDirectory() async {
    // Web documents directory - maps to IndexedDB
    // Persistent storage for user documents
    return '$_webStorageBasePath/documents';
  }

  @override
  Future<String?> getExternalStorageDirectory() async {
    // Web doesn't have external storage
    return null;
  }

  @override
  Future<List<String>?> getExternalCacheDirectories() async {
    // Web doesn't have external cache directories
    return null;
  }

  @override
  Future<List<String>?> getExternalStorageDirectories() async {
    // Web doesn't have external storage directories
    return null;
  }

  @override
  Future<String?> getDownloadsDirectory() async {
    // Web downloads - uses browser's download mechanism
    // This is a virtual path; actual downloads go through browser API
    return '$_webStorageBasePath/downloads';
  }

  @override
  Future<String?> getPublicPicturesDirectory() async {
    // Web doesn't have direct access to system directories
    // Return virtual path for pictures storage
    return '$_webStorageBasePath/pictures';
  }

  @override
  Future<String?> getPublicVideosDirectory() async {
    // Web doesn't have direct access to system directories
    // Return virtual path for videos storage
    return '$_webStorageBasePath/videos';
  }

  @override
  Future<String?> getPublicMusicDirectory() async {
    // Web doesn't have direct access to system directories
    // Return virtual path for music storage
    return '$_webStorageBasePath/music';
  }

  @override
  Future<String?> getPublicDownloadsDirectory() async {
    // Same as getDownloadsDirectory for web
    return '$_webStorageBasePath/downloads';
  }

  @override
  Future<String?> getPublicDocumentsDirectory() async {
    // Web public documents - virtual path
    return '$_webStorageBasePath/public_documents';
  }

  @override
  Future<String?> getPublicDCIMDirectory() async {
    // Web doesn't have DCIM directory
    return null;
  }
}

/// Web-specific notes:
/// 
/// 1. All paths are virtual and map to browser storage APIs
/// 2. Storage is limited by browser quotas (typically 50-100MB)
/// 3. Use IndexedDB or localStorage for actual file storage
/// 4. Downloads must use browser's download API (anchor tag with download attribute)
/// 5. No direct access to user's file system without explicit user permission
/// 6. Consider using File System Access API for modern browsers
/// 
/// Example usage with IndexedDB:
/// ```dart
/// import 'dart:html' as html;
/// 
/// Future<void> saveFileWeb(String path, List<int> bytes) async {
///   final blob = html.Blob([bytes]);
///   final url = html.Url.createObjectUrlFromBlob(blob);
///   final anchor = html.AnchorElement(href: url)
///     ..setAttribute('download', 'filename.txt')
///     ..click();
///   html.Url.revokeObjectUrl(url);
/// }
/// ```
/// 
/// For storage management, use the Storage API:
/// ```dart
/// import 'dart:html' as html;
/// 
/// Future<void> checkStorageQuota() async {
///   final storage = html.window.navigator.storage;
///   if (storage != null) {
///     // Check storage estimate
///     // Note: API usage varies by browser
///   }
/// }
/// ```
