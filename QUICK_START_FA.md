# راهنمای سریع - Path Provider Master

## نصب

در فایل `pubspec.yaml` پروژه خود:

```yaml
dependencies:
  path_provider_master:
    path: ../  # یا مسیر پلاگین
```

سپس دستور زیر را اجرا کنید:
```bash
flutter pub get
```

## استفاده سریع

### 1. Import کردن پکیج
```dart
import 'package:path_provider_master/path_provider_master.dart';
import 'dart:io';
```

### 2. دریافت مسیرهای مختلف

#### دایرکتوری موقت (برای فایل‌های کش)
```dart
final tempDir = await PathProviderMaster.getTemporaryDirectory();
print(tempDir?.path);
```

#### دایرکتوری اسناد (برای فایل‌های کاربر)
```dart
final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
print(docsDir?.path);
```

#### دایرکتوری دانلودها
```dart
final downloadsDir = await PathProviderMaster.getDownloadsDirectory();
print(downloadsDir?.path);
```

#### دایرکتوری عمومی تصاویر
```dart
final picturesDir = await PathProviderMaster.getPublicPicturesDirectory();
print(picturesDir?.path);
```

#### دایرکتوری عمومی ویدیوها
```dart
final videosDir = await PathProviderMaster.getPublicVideosDirectory();
print(videosDir?.path);
```

## مثال‌های کاربردی

### ذخیره فایل متنی
```dart
Future<void> saveTextFile() async {
  final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
  if (docsDir != null) {
    final file = File('${docsDir.path}/myfile.txt');
    await file.writeAsString('سلام دنیا!');
    print('فایل ذخیره شد: ${file.path}');
  }
}
```

### ذخیره تصویر
```dart
Future<void> saveImage(Uint8List imageBytes) async {
  final picturesDir = await PathProviderMaster.getPublicPicturesDirectory();
  if (picturesDir != null) {
    // ایجاد دایرکتوری در صورت عدم وجود
    if (!await picturesDir.exists()) {
      await picturesDir.create(recursive: true);
    }
    
    final file = File('${picturesDir.path}/my_image.jpg');
    await file.writeAsBytes(imageBytes);
    print('تصویر ذخیره شد: ${file.path}');
  }
}
```

### خواندن فایل
```dart
Future<String?> readTextFile() async {
  final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
  if (docsDir != null) {
    final file = File('${docsDir.path}/myfile.txt');
    if (await file.exists()) {
      return await file.readAsString();
    }
  }
  return null;
}
```

### پاک کردن کش
```dart
Future<void> clearCache() async {
  final tempDir = await PathProviderMaster.getTemporaryDirectory();
  if (tempDir != null && await tempDir.exists()) {
    final files = tempDir.listSync();
    for (var file in files) {
      try {
        await file.delete(recursive: true);
      } catch (e) {
        print('خطا در حذف: $e');
      }
    }
    print('کش پاک شد');
  }
}
```

### دریافت لیست فایل‌ها
```dart
Future<List<String>> listFiles() async {
  final docsDir = await PathProviderMaster.getApplicationDocumentsDirectory();
  if (docsDir != null && await docsDir.exists()) {
    final files = docsDir.listSync();
    return files.map((f) => f.path).toList();
  }
  return [];
}
```

## تمام متدهای موجود

| متد | توضیحات | Android | iOS | Windows | macOS | Linux |
|-----|---------|---------|-----|---------|-------|-------|
| `getTemporaryDirectory()` | دایرکتوری موقت | ✅ | ✅ | ✅ | ✅ | ✅ |
| `getApplicationSupportDirectory()` | دایرکتوری پشتیبانی | ✅ | ✅ | ✅ | ✅ | ✅ |
| `getLibraryDirectory()` | دایرکتوری Library | ❌ | ✅ | ❌ | ✅ | ❌ |
| `getApplicationDocumentsDirectory()` | دایرکتوری اسناد | ✅ | ✅ | ✅ | ✅ | ✅ |
| `getExternalStorageDirectory()` | حافظه خارجی | ✅ | ❌ | ❌ | ❌ | ❌ |
| `getExternalCacheDirectories()` | کش‌های خارجی | ✅ | ❌ | ❌ | ❌ | ❌ |
| `getExternalStorageDirectories()` | حافظه‌های خارجی | ✅ | ❌ | ❌ | ❌ | ❌ |
| `getDownloadsDirectory()` | دایرکتوری دانلودها | ✅ | ✅ | ✅ | ✅ | ✅ |
| `getPublicPicturesDirectory()` | تصاویر عمومی | ✅ | ✅ | ✅ | ✅ | ✅ |
| `getPublicVideosDirectory()` | ویدیوهای عمومی | ✅ | ✅ | ✅ | ✅ | ✅ |
| `getPublicMusicDirectory()` | موسیقی عمومی | ✅ | ✅ | ✅ | ✅ | ✅ |
| `getPublicDownloadsDirectory()` | دانلودهای عمومی | ✅ | ✅ | ✅ | ✅ | ✅ |
| `getPublicDocumentsDirectory()` | اسناد عمومی | ✅ | ✅ | ✅ | ✅ | ✅ |
| `getPublicDCIMDirectory()` | دایرکتوری دوربین | ✅ | ❌ | ❌ | ❌ | ❌ |

## نکات مهم

### 1. بررسی null
همیشه نتیجه را برای `null` بررسی کنید:
```dart
final dir = await PathProviderMaster.getPublicPicturesDirectory();
if (dir != null) {
  // استفاده از dir
}
```

### 2. ایجاد دایرکتوری
قبل از نوشتن فایل، مطمئن شوید دایرکتوری وجود دارد:
```dart
if (!await dir.exists()) {
  await dir.create(recursive: true);
}
```

### 3. مدیریت خطا
از try-catch استفاده کنید:
```dart
try {
  final file = File('${dir.path}/file.txt');
  await file.writeAsString('content');
} catch (e) {
  print('خطا: $e');
}
```

### 4. مجوزهای Android
برای دسترسی به حافظه خارجی، در `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

## اجرای مثال

```bash
cd example
flutter run
```

## پشتیبانی

برای مشاهده مثال‌های بیشتر:
- `example/lib/main.dart` - رابط کاربری کامل
- `example/lib/simple_example.dart` - مثال ساده
- `example/lib/usage_example.dart` - مثال‌های کاربردی

برای مستندات کامل API:
- `API_DOCUMENTATION.md`

## لایسنس
MIT License
