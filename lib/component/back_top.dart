// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/component/image/asset_image.dart';

import 'package:jd_mall_flutter/generated/assets.dart';

Widget backTop(bool showBackTop, ScrollController controller) {
  return Visibility(
    visible: showBackTop,
    child: SizedBox(
      width: 48,
      height: 48,
      child: FloatingActionButton(
        onPressed: () => controller.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.linear),
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: assetImage(Assets.imagesIcBackTop, 28, 28),
      ),
    ),
  );
}
