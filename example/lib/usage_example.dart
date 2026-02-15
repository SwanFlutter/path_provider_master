import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path_provider_master/path_provider_master.dart';

/// مثال‌های کاربردی استفاده از Path Provider Master

class PathProviderUsageExamples {
  /// ذخیره فایل در دایرکتوری موقت
  static Future<File> saveToTempDirectory(String content) async {
    final tempDir = await PathProviderMaster.getTemporaryDirectory();
    if (tempDir == null) throw Exception('Temp directory not available');

    final file = File('${tempDir.path}/temp_file.txt');
    await file.writeAsString(content);
    debugPrint('✅ File saved to: ${file.path}');
    return file;
  }

  /// ذخیره فایل در دایرکتوری اسناد
  static Future<File> saveToDocuments(String fileName, String content) async {
    final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
    if (docsDir == null) throw Exception('Documents directory not available');

    // ایجاد دایرکتوری در صورت عدم وجود
    if (!await docsDir.exists()) {
      await docsDir.create(recursive: true);
    }

    final file = File('${docsDir.path}/$fileName');
    await file.writeAsString(content);
    debugPrint('✅ Document saved to: ${file.path}');
    return file;
  }

  /// ذخیره تصویر در دایرکتوری عمومی تصاویر
  static Future<File?> saveImageToPublicPictures(
    String fileName,
    List<int> imageBytes,
  ) async {
    final picturesDir = await PathProviderMaster.getPublicPicturesDirectory();
    if (picturesDir == null) {
      debugPrint('⚠️ Public pictures directory not available on this platform');
      return null;
    }

    // ایجاد دایرکتوری در صورت عدم وجود
    if (!await picturesDir.exists()) {
      await picturesDir.create(recursive: true);
    }

    final file = File('${picturesDir.path}/$fileName');
    await file.writeAsBytes(imageBytes);
    debugPrint('✅ Image saved to: ${file.path}');
    return file;
  }

  /// ذخیره ویدیو در دایرکتوری عمومی ویدیوها
  static Future<File?> saveVideoToPublicVideos(
    String fileName,
    List<int> videoBytes,
  ) async {
    final videosDir = await PathProviderMaster.getPublicVideosDirectory();
    if (videosDir == null) {
      debugPrint('⚠️ Public videos directory not available on this platform');
      return null;
    }

    if (!await videosDir.exists()) {
      await videosDir.create(recursive: true);
    }

    final file = File('${videosDir.path}/$fileName');
    await file.writeAsBytes(videoBytes);
    debugPrint('✅ Video saved to: ${file.path}');
    return file;
  }

  /// دانلود فایل به دایرکتوری دانلودها
  static Future<File?> downloadFile(
    String fileName,
    List<int> fileBytes,
  ) async {
    final downloadsDir = await PathProviderMaster.getDownloadsDirectory();
    if (downloadsDir == null) {
      debugPrint('⚠️ Downloads directory not available on this platform');
      return null;
    }

    if (!await downloadsDir.exists()) {
      await downloadsDir.create(recursive: true);
    }

    final file = File('${downloadsDir.path}/$fileName');
    await file.writeAsBytes(fileBytes);
    debugPrint('✅ File downloaded to: ${file.path}');
    return file;
  }

  /// پاک کردن کش موقت
  static Future<void> clearTempCache() async {
    final tempDir = await PathProviderMaster.getTemporaryDirectory();
    if (tempDir == null) return;

    if (await tempDir.exists()) {
      final files = tempDir.listSync();
      for (var file in files) {
        try {
          if (file is File) {
            await file.delete();
          } else if (file is Directory) {
            await file.delete(recursive: true);
          }
        } catch (e) {
          debugPrint('⚠️ Error deleting ${file.path}: $e');
        }
      }
      debugPrint('✅ Temp cache cleared');
    }
  }

  /// دریافت اطلاعات فضای ذخیره‌سازی
  static Future<Map<String, dynamic>> getStorageInfo() async {
    final info = <String, dynamic>{};

    // دایرکتوری موقت
    final tempDir = await PathProviderMaster.getTemporaryDirectory();
    info['temp'] = tempDir?.path;

    // دایرکتوری اسناد
    final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
    info['documents'] = docsDir?.path;

    // دایرکتوری پشتیبانی
    final supportDir =
        await PathProviderMaster.getApplicationSupportDirectory();
    info['support'] = supportDir?.path;

    // حافظه خارجی (Android)
    final externalDir = await PathProviderMaster.getExternalStorageDirectory();
    info['external'] = externalDir?.path;

    // لیست حافظه‌های خارجی
    final storageDirs =
        await PathProviderMaster.getExternalStorageDirectories();
    info['external_storages'] = storageDirs?.map((d) => d.path).toList();

    return info;
  }

  /// بررسی فضای خالی دایرکتوری
  static Future<int> getDirectorySize(Directory dir) async {
    int totalSize = 0;

    if (await dir.exists()) {
      await for (var entity in dir.list(recursive: true, followLinks: false)) {
        if (entity is File) {
          try {
            totalSize += await entity.length();
          } catch (e) {
            debugPrint('⚠️ Error reading file size: $e');
          }
        }
      }
    }

    return totalSize;
  }

  /// فرمت کردن سایز به واحد قابل خواندن
  static String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
}

/// مثال استفاده
void main() async {
  // ذخیره فایل در دایرکتوری موقت
  await PathProviderUsageExamples.saveToTempDirectory('Hello World!');

  // ذخیره سند
  await PathProviderUsageExamples.saveToDocuments(
    'my_document.txt',
    'This is my document content',
  );

  // دریافت اطلاعات ذخیره‌سازی
  final storageInfo = await PathProviderUsageExamples.getStorageInfo();
  debugPrint('📊 Storage Info: $storageInfo');

  // محاسبه سایز دایرکتوری موقت
  final tempDir = await PathProviderMaster.getTemporaryDirectory();
  if (tempDir != null) {
    final size = await PathProviderUsageExamples.getDirectorySize(tempDir);
    debugPrint(
      '📦 Temp directory size: ${PathProviderUsageExamples.formatBytes(size)}',
    );
  }
}
