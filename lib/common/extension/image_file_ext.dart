// Flutter imports:
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:jd_mall_flutter/common/cache/cache_asset_service.dart';
import 'package:jd_mall_flutter/common/extension/num_ext.dart';

/// 图片文件扩展方法
extension ImageFileExt on File {
  /// 图片压缩
  Future<File> toCompressImage() async {
    var compressFile = await compressAndGetFile(this);
    compressFile ??= this; // 压缩失败则使用原图
    return compressFile;
  }

  /// 图像裁剪
  Future<File> toCropImage({
    int? maxWidth,
    int? maxHeight,
  }) async {
    try {
      final sourcePath = path;

      var croppedFile = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '裁剪',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: '裁剪',
            doneButtonTitle: "确定",
            cancelButtonTitle: "取消",
          ),
        ],
      );
      if (croppedFile == null) {
        return this;
      }
      return File(croppedFile.path);
    } catch (e) {
      debugPrint("toCropImage: $e");
      return this;
    }
  }
}

/// 图片压缩
Future<File> compressAndGetFile(File file, [String? targetPath]) async {
  try {
    var fileName = file.absolute.path.split('/').last;

    // Directory tempDir = await getTemporaryDirectory();
    // Directory assetDir = Directory('${tempDir.path}/asset');
    // if (!assetDir.existsSync()) {
    //   assetDir.createSync();
    //   debugPrint('assetDir 文件保存路径为 ${assetDir.path}');
    // }

    Directory? assetDir = await CacheAssetService().getDir();
    var tmpPath = '${assetDir.path}/$fileName';
    targetPath ??= tmpPath;
    // debugPrint('fileName_${fileName}');
    // debugPrint('assetDir_${assetDir}');
    // debugPrint('targetPath_${targetPath}');

    final compressQuality = file.lengthSync().compressQuality;

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: compressQuality,
      rotate: 0,
    );
    final path = result?.path;
    if (result == null || path == null || path.isEmpty) {
      debugPrint("压缩文件路径获取失败");
      return file;
    }
    final lenth = await result.length();

    final infos = [
      "图片名称: $fileName",
      "压缩前: ${file.lengthSync().fileSizeDesc}",
      "压缩质量: $compressQuality",
      "压缩后: ${lenth.fileSizeDesc}",
      "原路径: ${file.absolute.path}",
      "压缩路径: $targetPath",
    ];
    debugPrint("图片压缩: ${infos.join("\n")}");

    return File(path);
  } catch (e) {
    debugPrint("compressAndGetFile:${e.toString()}");
  }
  return file;
}

/// 图片压缩
Future<String> compressAndGetFilePath(
  String imagePath, [
  String? targetPath,
]) async {
  try {
    final file = File(imagePath);
    final fileNew = await compressAndGetFile(file, targetPath);
    final result = fileNew?.path ?? imagePath;
    return result;
  } catch (e) {
    debugPrint("compressAndGetFilePath:${e.toString()}");
  }
  return imagePath;
}
