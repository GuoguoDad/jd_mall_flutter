// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';

Widget floatingHeader(BuildContext context, {required String title, Color? bgColor}) {
  double statusHeight = getStatusHeight(context);

  return Positioned(
    top: 0,
    left: 0,
    child: Container(
      height: 40 + statusHeight,
      color: bgColor ?? Colors.white,
      width: getScreenWidth(context),
      padding: EdgeInsets.only(top: statusHeight),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16),
                child: assetImage("images/ic_back_black.png", 32, 32),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black, fontSize: 20)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                assetImage("images/ic_share_black.png", 24, 24),
                Container(
                  margin: const EdgeInsets.only(left: 14),
                  child: assetImage("images/ic_ellipsis_black.png", 24, 24),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
