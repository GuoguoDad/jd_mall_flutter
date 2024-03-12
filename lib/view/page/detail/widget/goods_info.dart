// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:jd_mall_flutter/view/page/detail/detail_controller.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/address_info.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/img_slider.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/sku_info.dart';

import '../../home/util.dart';

Widget goodsInfo(BuildContext context) {
  return SliverToBoxAdapter(
    child: Column(
      key: cardKeys[0],
      children: [
        imgSlider(context),
        skuInfo(context),
        addressInfo(context),
      ],
    ),
  );
}
