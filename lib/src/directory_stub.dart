// Copyright (c) path_provider_master
// Stub implementation of Directory for WASM/web environments
// where dart:io is not available.

/// A minimal stub for [Directory] used on platforms where dart:io
/// is unavailable (e.g. WASM/web). Only exposes [path].
class Directory {
  /// The path of this directory.
  final String path;

  const Directory(this.path);

  @override
  String toString() => "Directory: '$path'";
}
