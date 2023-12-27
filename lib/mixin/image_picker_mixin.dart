// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

// Project imports:
import 'package:jd_mall_flutter/common/extension/image_file_ext.dart';

mixin ImagePickerMixin<T extends StatefulWidget> on State<T> {
  final ImagePicker _picker = ImagePicker();

  updateAvatar({bool needCropp = true, Function(String? path)? callback}) {
    final titles = ['拍摄', '从相册选择'];

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: titles.map((e) {
            return CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                if (e == titles[0]) {
                  handleImageFromCamera(needCropp: needCropp, cb: callback);
                } else {
                  handleImageFromPhotoAlbum(needCropp: needCropp, cb: callback);
                }
              },
              child: Text(e),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('取消'),
          ),
        );
      },
    );
  }

  /// 拍照获取图像
  Future<String?> handleImageFromCamera({
    bool needCropp = true,
    required Function(String? path)? cb,
  }) async {
    final file = await _takePhoto();
    if (file == null) {
      // EasyLoading.showToast('请重新拍摄');
      return null;
    }

    // EasyLoading.sho(context, message: "图片处理中...");
    final compressImageFile = await file.toCompressImage();
    if (!needCropp) {
      // NOverlay.hide();
      cb?.call(compressImageFile.path);
      return compressImageFile.path;
    }

    final cropImageFile = await compressImageFile.toCropImage();
    // NOverlay.hide();

    cb?.call(cropImageFile.path);
    return cropImageFile.path;
  }

  Future<String?> handleImageFromPhotoAlbum({
    bool needCropp = true,
    Function(String? path)? cb,
  }) async {
    final file = await _chooseAvatarByWechatPicker();
    if (file == null) {
      // EasyLoading.showToast(
      //   '请重新选择',
      // );
      return null;
    }
    // NOverlay.showLoading(context, message: "图片处理中...");

    final compressImageFile = await file.toCompressImage();
    if (!needCropp) {
      // NOverlay.hide();
      cb?.call(compressImageFile.path);
      return compressImageFile.path;
    }

    final cropImageFile = await compressImageFile.toCropImage();
    // NOverlay.hide();

    cb?.call(cropImageFile.path);
    return cropImageFile.path;
  }

  /// 拍照
  Future<File?> _takePhoto() async {
    try {
      final file = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      if (file == null) {
        return null;
      }
      var fileNew = File(file.path);
      return fileNew;
    } catch (err) {}
    return null;
  }

  /// 通过微信相册选择器选择头像
  Future<File?> _chooseAvatarByWechatPicker() async {
    var maxCount = 1;

    final entitys = await AssetPicker.pickAssets(
          context,
          pickerConfig: AssetPickerConfig(
            requestType: RequestType.image,
            textDelegate: assetPickerTextDelegateFromLocale(Localizations.localeOf(context)),
            specialPickerType: SpecialPickerType.noPreview,
            selectedAssets: [],
            maxAssets: maxCount,
          ),
        ) ??
        [];

    if (entitys.isEmpty) {
      return null;
    }
    final item = entitys[0];
    final file = await item.file;
    if (file == null) {
      return null;
    }
    return file;
  }
}
