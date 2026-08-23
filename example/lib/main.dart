import 'package:flutter/material.dart';
import 'package:path_provider_master/path_provider_master.dart';

void main() {
  runApp(const WebExampleApp());
}

class WebExampleApp extends StatelessWidget {
  const WebExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Path Provider Master - Web Example',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Map<String, String?> _paths = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAllPaths();
  }

  Future<void> _loadAllPaths() async {
    setState(() {
      _isLoading = true;
    });

    final pathEntries = <(String, Future<String?> Function())>[
      (
        'Temporary Directory',
        () async => (await PathProviderMaster.getTemporaryDirectory())?.path,
      ),
      (
        'Application Support',
        () async =>
            (await PathProviderMaster.getApplicationSupportDirectory())?.path,
      ),
      (
        'Library Directory',
        () async => (await PathProviderMaster.getLibraryDirectory())?.path,
      ),
      (
        'Application Documents',
        () async =>
            (await PathProviderMaster.getApplicationDocumentsDirectory())?.path,
      ),
      (
        'External Storage',
        () async =>
            (await PathProviderMaster.getExternalStorageDirectory())?.path,
      ),
      (
        'Downloads Directory',
        () async => (await PathProviderMaster.getDownloadsDirectory())?.path,
      ),
      (
        'Public Pictures',
        () async =>
            (await PathProviderMaster.getPublicPicturesDirectory())?.path,
      ),
      (
        'Public Videos',
        () async => (await PathProviderMaster.getPublicVideosDirectory())?.path,
      ),
      (
        'Public Music',
        () async => (await PathProviderMaster.getPublicMusicDirectory())?.path,
      ),
      (
        'Public Downloads',
        () async =>
            (await PathProviderMaster.getPublicDownloadsDirectory())?.path,
      ),
      (
        'Public Documents',
        () async =>
            (await PathProviderMaster.getPublicDocumentsDirectory())?.path,
      ),
      (
        'Public DCIM',
        () async => (await PathProviderMaster.getPublicDCIMDirectory())?.path,
      ),
    ];

    for (var entry in pathEntries) {
      try {
        final path = await entry.$2();
        _paths[entry.$1] = path ?? 'غیرقابل دسترس';
      } catch (e) {
        _paths[entry.$1] = 'خطا: $e';
      }
    }

    // دریافت لیست دایرکتوری‌های کش خارجی
    try {
      final cacheDirs = await PathProviderMaster.getExternalCacheDirectories();
      if (cacheDirs != null && cacheDirs.isNotEmpty) {
        for (int i = 0; i < cacheDirs.length; i++) {
          _paths['External Cache $i'] = cacheDirs[i].path;
        }
      } else {
        _paths['External Cache Directories'] = 'غیرقابل دسترس';
      }
    } catch (e) {
      _paths['External Cache Directories'] = 'خطا: $e';
    }

    // دریافت لیست دایرکتوری‌های حافظه خارجی
    try {
      final storageDirs =
          await PathProviderMaster.getExternalStorageDirectories();
      if (storageDirs != null && storageDirs.isNotEmpty) {
        for (int i = 0; i < storageDirs.length; i++) {
          _paths['External Storage $i'] = storageDirs[i].path;
        }
      } else {
        _paths['External Storage Directories'] = 'غیرقابل دسترس';
      }
    } catch (e) {
      _paths['External Storage Directories'] = 'خطا: $e';
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Path Provider Master - نمونه'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _loadAllPaths,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _paths.length,
                  itemBuilder: (context, index) {
                    final entry = _paths.entries.elementAt(index);
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      child: ListTile(
                        title: Text(
                          entry.key,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            entry.value ?? 'در حال بارگذاری...',
                            style: TextStyle(
                              fontSize: 13,
                              color: entry.value == 'غیرقابل دسترس'
                                  ? Colors.red
                                  : Colors.black87,
                            ),
                          ),
                        ),
                        leading: Icon(
                          _getIconForPath(entry.key),
                          color: Colors.blue,
                          size: 32,
                        ),
                        trailing:
                            entry.value != null &&
                                entry.value != 'غیرقابل دسترس' &&
                                !entry.value!.startsWith('خطا')
                            ? IconButton(
                                icon: const Icon(Icons.copy, size: 20),
                                onPressed: () {
                                  // کپی مسیر به کلیپ‌بورد
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'مسیر کپی شد: ${entry.value}',
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: _loadAllPaths,
          tooltip: 'بارگذاری مجدد',
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }

  IconData _getIconForPath(String pathName) {
    if (pathName.contains('Pictures') || pathName.contains('DCIM')) {
      return Icons.photo_library;
    } else if (pathName.contains('Videos')) {
      return Icons.video_library;
    } else if (pathName.contains('Music')) {
      return Icons.music_note;
    } else if (pathName.contains('Downloads')) {
      return Icons.download;
    } else if (pathName.contains('Documents')) {
      return Icons.description;
    } else if (pathName.contains('Temporary') || pathName.contains('Cache')) {
      return Icons.cached;
    } else if (pathName.contains('External')) {
      return Icons.sd_storage;
    } else {
      return Icons.folder;
    }
  }
}
