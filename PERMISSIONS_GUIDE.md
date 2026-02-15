
# Path Provider Master – Permissions Guide

This guide explains how to set up the necessary permissions for using the plugin on different platforms.

---

## Android

### External Storage Permissions

To access external storage and public directories, add the following permissions.

#### File: `android/app/src/main/AndroidManifest.xml`

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- Read external storage permission -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>

    <!-- Write external storage permission -->
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

    <!-- For Android 13 and above - Access to images -->
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>

    <!-- For Android 13 and above - Access to videos -->
    <uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>

    <!-- For Android 13 and above - Access to audio files -->
    <uses-permission android:name="android.permission.READ_MEDIA_AUDIO"/>

    <application>
        ...
    </application>
</manifest>
```

### Runtime Permission Request (Android 6.0+)

For Android 6.0 and above, request permissions at runtime:

```dart
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestStoragePermission() async {
  // For Android 13 and above
  if (await Permission.photos.request().isGranted) {
    return true;
  }

  // For older versions
  if (await Permission.storage.request().isGranted) {
    return true;
  }

  return false;
}

// Usage
void main() async {
  if (await requestStoragePermission()) {
    final picturesDir = await PathProviderMaster.getPublicPicturesDirectory();
    // Use the directory
  } else {
    print('Permission denied');
  }
}
```

### Install the `permission_handler` Package

```yaml
dependencies:
  permission_handler: ^11.0.0
```

### Scoped Storage Settings (Android 10+)

If you want to opt out of Scoped Storage (not recommended):

```xml
<application
    android:requestLegacyExternalStorage="true">
    ...
</application>
```

---

## iOS

### Info.plist Settings

To access certain directories, add descriptions in `Info.plist`.

#### File: `ios/Runner/Info.plist`

```xml
<dict>
    <!-- Photo library access -->
    <key>NSPhotoLibraryUsageDescription</key>
    <string>This app needs access to the photo library</string>

    <key>NSPhotoLibraryAddUsageDescription</key>
    <string>This app wants to save photos to the library</string>

    <!-- Camera access -->
    <key>NSCameraUsageDescription</key>
    <string>This app needs access to the camera</string>

    <!-- Microphone access -->
    <key>NSMicrophoneUsageDescription</key>
    <string>This app needs access to the microphone</string>

    <!-- Music library access -->
    <key>NSAppleMusicUsageDescription</key>
    <string>This app needs access to the music library</string>
</dict>
```

### Request Permissions in iOS

```dart
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPhotosPermission() async {
  final status = await Permission.photos.request();
  return status.isGranted;
}

// Usage
void main() async {
  if (await requestPhotosPermission()) {
    final picturesDir = await PathProviderMaster.getPublicPicturesDirectory();
    // Use the directory
  }
}
```

---

## macOS

### Entitlements Settings

To access files on macOS, set up entitlements.

#### File: `macos/Runner/DebugProfile.entitlements`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- Access to user-selected files -->
    <key>com.apple.security.files.user-selected.read-write</key>
    <true/>

    <!-- Access to Downloads directory -->
    <key>com.apple.security.files.downloads.read-write</key>
    <true/>

    <!-- Access to Pictures directory -->
    <key>com.apple.security.files.pictures.read-write</key>
    <true/>

    <!-- Access to Music directory -->
    <key>com.apple.security.files.music.read-write</key>
    <true/>

    <!-- Access to Movies directory -->
    <key>com.apple.security.files.movies.read-write</key>
    <true/>

    <!-- Disable App Sandbox (for development) -->
    <key>com.apple.security.app-sandbox</key>
    <true/>
</dict>
</plist>
```

Apply the same settings to `Release.entitlements`.

---

## Windows

Windows usually does not require special permissions, but you may need to configure settings for certain directories.

### Capabilities Settings

#### File: `windows/runner/Runner.exe.manifest`

```xml
<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">
  <trustInfo xmlns="urn:schemas-microsoft-com:asm.v3">
    <security>
      <requestedPrivileges>
        <requestedExecutionLevel level="asInvoker" uiAccess="false"/>
      </requestedPrivileges>
    </security>
  </trustInfo>
</assembly>
```

---

## Linux

Linux usually does not require special permissions, but ensure your app has read/write access to user directories.

### Check Permissions

```bash
# Check directory permissions
ls -la ~/Pictures
ls -la ~/Videos
ls -la ~/Music
ls -la ~/Downloads
```

---

## Complete Example with Permission Management

```dart
import 'package:flutter/material.dart';
import 'package:path_provider_master/path_provider_master.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class PermissionExample extends StatefulWidget {
  @override
  _PermissionExampleState createState() => _PermissionExampleState();
}

class _PermissionExampleState extends State<PermissionExample> {
  String _status = 'Waiting...';

  Future<void> saveImageWithPermission() async {
    // Check platform
    if (Platform.isAndroid) {
      // Request permission for Android
      PermissionStatus status;

      if (await Permission.photos.isGranted) {
        status = PermissionStatus.granted;
      } else {
        status = await Permission.photos.request();
      }

      if (!status.isGranted) {
        setState(() {
          _status = 'Permission denied';
        });
        return;
      }
    } else if (Platform.isIOS) {
      // Request permission for iOS
      final status = await Permission.photos.request();

      if (!status.isGranted) {
        setState(() {
          _status = 'Permission denied';
        });
        return;
      }
    }

    // Save image
    try {
      final picturesDir = await PathProviderMaster.getPublicPicturesDirectory();

      if (picturesDir != null) {
        if (!await picturesDir.exists()) {
          await picturesDir.create(recursive: true);
        }

        final file = File('${picturesDir.path}/test_image.jpg');
        // Save image...

        setState(() {
          _status = 'Image saved: ${file.path}';
        });
      } else {
        setState(() {
          _status = 'Directory not available';
        });
      }
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Permission Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveImageWithPermission,
              child: Text('Save Image'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Important Notes

1. **Always check permissions** before accessing files.
2. **Provide clear explanations** for why you need permissions.
3. **Request permissions at the right time**, not at app startup.
4. **Show appropriate messages** if permission is denied.
5. **Use try-catch** to handle errors.

---

## Useful Resources

- [permission_handler package](https://pub.dev/packages/permission_handler)
- [Android Permissions Guide](https://developer.android.com/guide/topics/permissions/overview)
- [iOS Privacy Guide](https://developer.apple.com/documentation/uikit/protecting_the_user_s_privacy)