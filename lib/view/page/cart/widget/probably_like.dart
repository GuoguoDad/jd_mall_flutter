import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';

Widget probablyLikeImage(BuildContext context) {
  return SliverToBoxAdapter(
    child: Container(
      color: CommonStyle.colorF3F3F3,
      child: assetImage('images/probably_like.png', getScreenWidth(context), 50),
    ),
  );
}
