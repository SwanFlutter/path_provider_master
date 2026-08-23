import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'path_provider_master_platform_interface.dart';

/// An implementation of [PathProviderMasterPlatform] that uses method channels.
class MethodChannelPathProviderMaster extends PathProviderMasterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('path_provider_master');

  @override
  Future<String?> getTemporaryDirectory() async {
    return await methodChannel.invokeMethod<String>('getTemporaryDirectory');
  }

  @override
  Future<String?> getApplicationSupportDirectory() async {
    return await methodChannel.invokeMethod<String>(
      'getApplicationSupportDirectory',
    );
  }

  @override
  Future<String?> getLibraryDirectory() async {
    return await methodChannel.invokeMethod<String>('getLibraryDirectory');
  }

  @override
  Future<String?> getApplicationDocumentsDirectory() async {
    return await methodChannel.invokeMethod<String>(
      'getApplicationDocumentsDirectory',
    );
  }

  @override
  Future<String?> getExternalStorageDirectory() async {
    return await methodChannel.invokeMethod<String>(
      'getExternalStorageDirectory',
    );
  }

  @override
  Future<List<String>?> getExternalCacheDirectories() async {
    final result = await methodChannel.invokeMethod<List<dynamic>>(
      'getExternalCacheDirectories',
    );
    return result?.cast<String>();
  }

  @override
  Future<List<String>?> getExternalStorageDirectories() async {
    final result = await methodChannel.invokeMethod<List<dynamic>>(
      'getExternalStorageDirectories',
    );
    return result?.cast<String>();
  }

  @override
  Future<String?> getDownloadsDirectory() async {
    return await methodChannel.invokeMethod<String>('getDownloadsDirectory');
  }

  @override
  Future<String?> getPublicPicturesDirectory() async {
    return await methodChannel.invokeMethod<String>(
      'getPublicPicturesDirectory',
    );
  }

  @override
  Future<String?> getPublicVideosDirectory() async {
    return await methodChannel.invokeMethod<String>('getPublicVideosDirectory');
  }

  @override
  Future<String?> getPublicMusicDirectory() async {
    return await methodChannel.invokeMethod<String>('getPublicMusicDirectory');
  }

  @override
  Future<String?> getPublicDownloadsDirectory() async {
    return await methodChannel.invokeMethod<String>(
      'getPublicDownloadsDirectory',
    );
  }

  @override
  Future<String?> getPublicDocumentsDirectory() async {
    return await methodChannel.invokeMethod<String>(
      'getPublicDocumentsDirectory',
    );
  }

  @override
  Future<String?> getPublicDCIMDirectory() async {
    return await methodChannel.invokeMethod<String>('getPublicDCIMDirectory');
  }
}
