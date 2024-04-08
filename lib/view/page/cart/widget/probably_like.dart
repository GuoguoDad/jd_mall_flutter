// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';

Widget probablyLike() {
  return SliverToBoxAdapter(
    child: Container(
      color: CommonStyle.colorF3F3F3,
      child: assetImage('images/probably_like.png', getScreenWidth(), 50),
    ),
  );
}
