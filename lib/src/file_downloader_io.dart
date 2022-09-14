import 'dart:convert';
import 'dart:io';

import 'package:file_android/file_android.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_download_manager/flutter_download_manager.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'file_downloader.dart';

FileDownloader getManager() => FileDownloaderIo();

class FileDownloaderIo implements FileDownloader {
  final downloadManager = DownloadManager();

  @override
  Future<void> downloadFromUrl({
    required String url,
    required String fileName,
    VoidCallback? onStart,
    VoidCallback? onDone,
  }) async {
    final localPath = await _getDirectoryPath();

    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    final task = await downloadManager.addDownload(url, savedDir.path);

    if (task != null) {
      onStart?.call();
      task.whenDownloadComplete().then((value) async {
        if (value.isCompleted) {
          onDone?.call();

          if (Platform.isAndroid) {
            FileAndroid().salvarArquivoBase64(
              nomeArquivo: fileName,
              mimetypeArquivo: mime(url)!,
              base64: base64Encode(File(task.request.path).readAsBytesSync()),
            );
          } else if (Platform.isIOS) {
            Share.shareFiles([task.request.path]);
          }
        }
      });
    }
  }

  @override
  Future<void> shareFromUrl({
    required String url,
    required String fileName,
    VoidCallback? onStart,
  }) async {
    final dir = await getApplicationSupportDirectory();
    final task = await downloadManager.addDownload(url, dir.path);
    if (task != null) {
      onStart?.call();

      task.whenDownloadComplete().then((value) {
        if (value.isCompleted) {
          Share.shareFiles([task.request.path]);
        }
      });
    }
  }

  static Future<String> _getDirectoryPath() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      return dir.path;
    }
    // Desktop
    else {
      final dir = await getDownloadsDirectory();
      return dir!.path;
    }
  }
}
