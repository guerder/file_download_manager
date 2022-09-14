// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:mime_type/mime_type.dart';

import 'file_downloader.dart';

Future<void> initConfig() async {}

FileDownloader getManager() => FileDownloaderWeb();

class FileDownloaderWeb implements FileDownloader {
  @override
  Future<void> downloadFromUrl({
    required String url,
    required String fileName,
    VoidCallback? onStart,
    VoidCallback? onDone,
  }) async {
    try {
      final request = await get(Uri.parse(url));
      final fileBytes = request.bodyBytes;
      final mimeType = mime(url)!;
      fileName = '$fileName.${extensionFromMime(mimeType)}';
      html.AnchorElement(
          href: "data:$mimeType;base64,${base64Encode(fileBytes)}")
        ..setAttribute("download", fileName)
        ..click();
    } catch (_) {}
  }

  @override
  Future<void> shareFromUrl({
    required String url,
    required String fileName,
    VoidCallback? onStart,
  }) {
    throw UnimplementedError();
  }
}
