import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';

import '../../../common/style/common_style.dart';

Widget probablyLikeImage(BuildContext context) {
  return SliverToBoxAdapter(
      child: Container(
    color: CommonStyle.colorF3F3F3,
    child: assetImage('images/probably_like.png', MediaQuery.of(context).size.width, 60),
  ));
}
