// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:path_provider_master/path_provider_master.dart';

/// Example of using Path Provider Master on Web platform
///
/// Note: Web platform has different storage model:
/// - All paths are virtual and map to browser storage
/// - Storage is limited by browser quotas
/// - No direct file system access without user permission

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
      home: const WebExamplePage(),
    );
  }
}

class WebExamplePage extends StatefulWidget {
  const WebExamplePage({super.key});

  @override
  State<WebExamplePage> createState() => _WebExamplePageState();
}

class _WebExamplePageState extends State<WebExamplePage> {
  final Map<String, String?> _paths = {};
  bool _isLoading = false;
  String _statusMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPaths();
  }

  Future<void> _loadPaths() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Loading paths...';
    });

    try {
      final paths = {
        'Temporary Directory': await PathProviderMaster.getTemporaryDirectory(),
        'Application Support':
            await PathProviderMaster.getApplicationSupportDirectory(),
        'Application Documents':
            await PathProviderMaster.getApplicationDocumentsDirectory(),
        'Downloads Directory': await PathProviderMaster.getDownloadsDirectory(),
        'Public Pictures':
            await PathProviderMaster.getPublicPicturesDirectory(),
        'Public Videos': await PathProviderMaster.getPublicVideosDirectory(),
        'Public Music': await PathProviderMaster.getPublicMusicDirectory(),
        'Public Downloads':
            await PathProviderMaster.getPublicDownloadsDirectory(),
        'Public Documents':
            await PathProviderMaster.getPublicDocumentsDirectory(),
      };

      setState(() {
        _paths.clear();
        paths.forEach((key, value) {
          _paths[key] = value?.path ?? 'Not available';
        });
        _statusMessage = 'Paths loaded successfully';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error loading paths: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showWebStorageInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Web Storage Information'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Web Platform Storage Notes:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('• All paths are virtual and map to browser storage'),
              const Text(
                '• Storage is limited by browser quotas (typically 50-100MB)',
              ),
              const Text(
                '• Use IndexedDB or localStorage for actual file storage',
              ),
              const Text('• Downloads use browser\'s download API'),
              const Text(
                '• No direct file system access without user permission',
              ),
              const SizedBox(height: 16),
              const Text(
                'Recommended Storage APIs:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('• IndexedDB - for large binary data'),
              const Text('• localStorage - for small text data'),
              const Text('• File System Access API - for modern browsers'),
              const Text('• Cache API - for offline caching'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _simulateFileDownload() {
    if (!kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This feature is for web only')),
      );
      return;
    }

    // Simulate file download on web
    final content =
        'This is a test file created by Path Provider Master\n'
        'Timestamp: ${DateTime.now()}\n'
        'Platform: Web';

    // Create blob and download
    // Note: This requires dart:html which is only available on web
    if (kIsWeb) {
      // In a real app, you would use dart:html here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'File download simulated (use dart:html for actual download)',
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Path Provider Master - Web'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showWebStorageInfo,
            tooltip: 'Web Storage Info',
          ),
        ],
      ),
      body: Column(
        children: [
          // Platform indicator
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Row(
              children: [
                Icon(Icons.web, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  'Running on Web Platform',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),

          // Status message
          if (_statusMessage.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.grey.shade100,
              child: Text(
                _statusMessage,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
            ),

          // Paths list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _paths.length,
                    itemBuilder: (context, index) {
                      final entry = _paths.entries.elementAt(index);
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Icon(
                            _getIconForPath(entry.key),
                            color: Colors.blue,
                          ),
                          title: Text(
                            entry.key,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              entry.value ?? 'Not available',
                              style: TextStyle(
                                fontSize: 12,
                                color: entry.value == 'Not available'
                                    ? Colors.red
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Action buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _loadPaths,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reload Paths'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _simulateFileDownload,
                    icon: const Icon(Icons.download),
                    label: const Text('Test Download'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForPath(String pathName) {
    if (pathName.contains('Pictures')) {
      return Icons.photo_library;
    } else if (pathName.contains('Videos')) {
      return Icons.video_library;
    } else if (pathName.contains('Music')) {
      return Icons.music_note;
    } else if (pathName.contains('Downloads')) {
      return Icons.download;
    } else if (pathName.contains('Documents')) {
      return Icons.description;
    } else if (pathName.contains('Temporary')) {
      return Icons.cached;
    } else {
      return Icons.folder;
    }
  }
}

/// Helper class for web file operations
class WebFileHelper {
  /// Save text content as downloadable file (web only)
  static void downloadTextFile(String filename, String content) {
    if (!kIsWeb) return;

    // In a real implementation, use dart:html:
    // final blob = html.Blob([content], 'text/plain');
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // final anchor = html.AnchorElement(href: url)
    //   ..setAttribute('download', filename)
    //   ..click();
    // html.Url.revokeObjectUrl(url);
  }

  /// Save binary content as downloadable file (web only)
  static void downloadBinaryFile(String filename, List<int> bytes) {
    if (!kIsWeb) return;

    // In a real implementation, use dart:html:
    // final blob = html.Blob([bytes]);
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // final anchor = html.AnchorElement(href: url)
    //   ..setAttribute('download', filename)
    //   ..click();
    // html.Url.revokeObjectUrl(url);
  }
}
