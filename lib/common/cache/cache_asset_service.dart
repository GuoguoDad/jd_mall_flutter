import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

///缓存媒体文件
class CacheAssetService {
  CacheAssetService._();

  static final CacheAssetService _instance = CacheAssetService._();

  factory CacheAssetService() => _instance;


  Directory? _dir;

  Future<Directory> getDir() async {
    if (_dir != null) {
      return _dir!;
    }
    Directory tempDir = await getTemporaryDirectory();
    Directory targetDir = Directory('${tempDir.path}/asset');
    if (!targetDir.existsSync()) {
      targetDir.createSync();
      debugPrint('targetDir 路径为 ${targetDir.path}');
    }
    _dir = targetDir;
    return targetDir;
  }

  /// 清除缓存文件
  Future<void> clearDirCache() async {
    final dir = await getDir();
    await deleteDirectory(dir);
  }

  /// 递归方式删除目录
  Future<void> deleteDirectory(FileSystemEntity? file) async {
    if (file == null) {
      return;
    }

    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await deleteDirectory(child);
      }
    }
    await file.delete();
  }

}
