// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_controller.dart';

// Project imports:
import 'package:jd_mall_flutter/view/page/detail/widget/address_info.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/img_slider.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/sku_info.dart';

Widget goodsInfo(BuildContext context, Key key, DetailController c) {
  return SliverToBoxAdapter(
    child: Column(
      key: key,
      children: [
        imgSlider(context, c),
        skuInfo(context, c),
        addressInfo(context, c),
      ],
    ),
  );
}
