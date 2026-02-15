import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'path_provider_master_method_channel.dart';

abstract class PathProviderMasterPlatform extends PlatformInterface {
  /// Constructs a PathProviderMasterPlatform.
  PathProviderMasterPlatform() : super(token: _token);

  static final Object _token = Object();

  static PathProviderMasterPlatform _instance =
      MethodChannelPathProviderMaster();

  /// The default instance of [PathProviderMasterPlatform] to use.
  ///
  /// Defaults to [MethodChannelPathProviderMaster].
  static PathProviderMasterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PathProviderMasterPlatform] when
  /// they register themselves.
  static set instance(PathProviderMasterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getTemporaryDirectory() {
    throw UnimplementedError(
      'getTemporaryDirectory() has not been implemented.',
    );
  }

  Future<String?> getApplicationSupportDirectory() {
    throw UnimplementedError(
      'getApplicationSupportDirectory() has not been implemented.',
    );
  }

  Future<String?> getLibraryDirectory() {
    throw UnimplementedError('getLibraryDirectory() has not been implemented.');
  }

  Future<String?> getApplicationDocumentsDirectory() {
    throw UnimplementedError(
      'getApplicationDocumentsDirectory() has not been implemented.',
    );
  }

  Future<String?> getExternalStorageDirectory() {
    throw UnimplementedError(
      'getExternalStorageDirectory() has not been implemented.',
    );
  }

  Future<List<String>?> getExternalCacheDirectories() {
    throw UnimplementedError(
      'getExternalCacheDirectories() has not been implemented.',
    );
  }

  Future<List<String>?> getExternalStorageDirectories() {
    throw UnimplementedError(
      'getExternalStorageDirectories() has not been implemented.',
    );
  }

  Future<String?> getDownloadsDirectory() {
    throw UnimplementedError(
      'getDownloadsDirectory() has not been implemented.',
    );
  }

  Future<String?> getPublicPicturesDirectory() {
    throw UnimplementedError(
      'getPublicPicturesDirectory() has not been implemented.',
    );
  }

  Future<String?> getPublicVideosDirectory() {
    throw UnimplementedError(
      'getPublicVideosDirectory() has not been implemented.',
    );
  }

  Future<String?> getPublicMusicDirectory() {
    throw UnimplementedError(
      'getPublicMusicDirectory() has not been implemented.',
    );
  }

  Future<String?> getPublicDownloadsDirectory() {
    throw UnimplementedError(
      'getPublicDownloadsDirectory() has not been implemented.',
    );
  }

  Future<String?> getPublicDocumentsDirectory() {
    throw UnimplementedError(
      'getPublicDocumentsDirectory() has not been implemented.',
    );
  }

  Future<String?> getPublicDCIMDirectory() {
    throw UnimplementedError(
      'getPublicDCIMDirectory() has not been implemented.',
    );
  }
}
