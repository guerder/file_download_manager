import 'package:flutter/foundation.dart';

import 'file_downloader_stub.dart'
    if (dart.library.html) 'file_downloader_web.dart'
    if (dart.library.io) 'file_downloader_io.dart';

abstract class FileDownloader {
  static FileDownloader? _instance;

  factory FileDownloader() {
    return _instance ??= getManager();
  }

  Future<void> downloadFromUrl({
    required String url,
    required String fileName,
    VoidCallback? onStart,
    VoidCallback? onDone,
  });

  Future<void> shareFromUrl({
    required String url,
    required String fileName,
    VoidCallback? onStart,
  });
}
