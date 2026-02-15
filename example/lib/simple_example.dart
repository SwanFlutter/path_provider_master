import 'package:flutter/material.dart';
import 'package:path_provider_master/path_provider_master.dart';

/// مثال ساده استفاده از Path Provider Master
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // دریافت مسیر دایرکتوری موقت
  final tempDir = await PathProviderMaster.getTemporaryDirectory();
  debugPrint('📁 Temporary Directory: ${tempDir?.path}');

  // دریافت مسیر دایرکتوری اسناد
  final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
  debugPrint('📄 Documents Directory: ${docsDir?.path}');

  // دریافت مسیر دایرکتوری پشتیبانی
  final supportDir = await PathProviderMaster.getApplicationSupportDirectory();
  debugPrint('🔧 Support Directory: ${supportDir?.path}');

  // دریافت مسیر دایرکتوری دانلودها
  final downloadsDir = await PathProviderMaster.getDownloadsDirectory();
  debugPrint('⬇️ Downloads Directory: ${downloadsDir?.path}');

  // دریافت مسیر دایرکتوری عمومی تصاویر
  final picturesDir = await PathProviderMaster.getPublicPicturesDirectory();
  debugPrint('🖼️ Public Pictures: ${picturesDir?.path}');

  // دریافت مسیر دایرکتوری عمومی ویدیوها
  final videosDir = await PathProviderMaster.getPublicVideosDirectory();
  debugPrint('🎥 Public Videos: ${videosDir?.path}');

  // دریافت مسیر دایرکتوری عمومی موسیقی
  final musicDir = await PathProviderMaster.getPublicMusicDirectory();
  debugPrint('🎵 Public Music: ${musicDir?.path}');

  // دریافت لیست حافظه‌های خارجی (فقط Android)
  final storageDirs = await PathProviderMaster.getExternalStorageDirectories();
  if (storageDirs != null) {
    debugPrint('💾 External Storage Directories:');
    for (var i = 0; i < storageDirs.length; i++) {
      debugPrint('   [$i] ${storageDirs[i].path}');
    }
  }

  // دریافت لیست کش‌های خارجی (فقط Android)
  final cacheDirs = await PathProviderMaster.getExternalCacheDirectories();
  if (cacheDirs != null) {
    debugPrint('🗑️ External Cache Directories:');
    for (var i = 0; i < cacheDirs.length; i++) {
      debugPrint('   [$i] ${cacheDirs[i].path}');
    }
  }

  runApp(const SimpleApp());
}

class SimpleApp extends StatelessWidget {
  const SimpleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Path Provider Master - Simple Example'),
        ),
        body: const Center(
          child: Text(
            'مسیرها در کنسول چاپ شده‌اند\nCheck console for paths',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
