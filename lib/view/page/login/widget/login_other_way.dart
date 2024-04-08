// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/generated/assets.dart';

Widget loginOtherWay(BuildContext context) {
  return SizedBox(
    height: 100 + getBottomSpace(),
    width: getScreenWidth(),
    child: Column(
      children: [
        const Text("其他登录方式", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            assetImage(Assets.imagesWechat, 42, 42),
            const SizedBox(width: 20, height: 80),
            assetImage(Assets.imagesQq, 38, 38),
          ],
        )
      ],
    ),
  );
}
