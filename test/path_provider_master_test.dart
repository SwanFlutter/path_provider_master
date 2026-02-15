import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_master/path_provider_master_method_channel.dart';
import 'package:path_provider_master/path_provider_master_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPathProviderMasterPlatform
    with MockPlatformInterfaceMixin
    implements PathProviderMasterPlatform {
  @override
  Future<String?> getTemporaryDirectory() => Future.value('/tmp');

  @override
  Future<String?> getApplicationSupportDirectory() =>
      Future.value('/app/support');

  @override
  Future<String?> getLibraryDirectory() => Future.value('/library');

  @override
  Future<String?> getApplicationDocumentsDirectory() =>
      Future.value('/documents');

  @override
  Future<String?> getExternalStorageDirectory() => Future.value('/external');

  @override
  Future<List<String>?> getExternalCacheDirectories() =>
      Future.value(['/cache1', '/cache2']);

  @override
  Future<List<String>?> getExternalStorageDirectories() =>
      Future.value(['/storage1', '/storage2']);

  @override
  Future<String?> getDownloadsDirectory() => Future.value('/downloads');

  @override
  Future<String?> getPublicPicturesDirectory() => Future.value('/pictures');

  @override
  Future<String?> getPublicVideosDirectory() => Future.value('/videos');

  @override
  Future<String?> getPublicMusicDirectory() => Future.value('/music');

  @override
  Future<String?> getPublicDownloadsDirectory() =>
      Future.value('/public/downloads');

  @override
  Future<String?> getPublicDocumentsDirectory() =>
      Future.value('/public/documents');

  @override
  Future<String?> getPublicDCIMDirectory() => Future.value('/dcim');
}

void main() {
  final PathProviderMasterPlatform initialPlatform =
      PathProviderMasterPlatform.instance;

  test('$MethodChannelPathProviderMaster is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPathProviderMaster>());
  });

  test('getTemporaryDirectory returns correct path', () async {
    MockPathProviderMasterPlatform fakePlatform =
        MockPathProviderMasterPlatform();
    PathProviderMasterPlatform.instance = fakePlatform;

    expect(await fakePlatform.getTemporaryDirectory(), '/tmp');
  });

  test('getApplicationDocumentsDirectory returns correct path', () async {
    MockPathProviderMasterPlatform fakePlatform =
        MockPathProviderMasterPlatform();
    PathProviderMasterPlatform.instance = fakePlatform;

    expect(await fakePlatform.getApplicationDocumentsDirectory(), '/documents');
  });

  test('getPublicPicturesDirectory returns correct path', () async {
    MockPathProviderMasterPlatform fakePlatform =
        MockPathProviderMasterPlatform();
    PathProviderMasterPlatform.instance = fakePlatform;

    expect(await fakePlatform.getPublicPicturesDirectory(), '/pictures');
  });

  test('getExternalCacheDirectories returns list of paths', () async {
    MockPathProviderMasterPlatform fakePlatform =
        MockPathProviderMasterPlatform();
    PathProviderMasterPlatform.instance = fakePlatform;

    final result = await fakePlatform.getExternalCacheDirectories();
    expect(result, isA<List<String>>());
    expect(result?.length, 2);
  });
}
