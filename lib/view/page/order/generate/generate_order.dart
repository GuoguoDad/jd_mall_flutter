// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/component/common_header.dart';
import 'package:jd_mall_flutter/component/no_shadow_scroll_behavior.dart';
import 'package:jd_mall_flutter/view/page/order/generate/widget/bottom.dart';
import 'package:jd_mall_flutter/view/page/order/generate/widget/default_address.dart';
import 'package:jd_mall_flutter/view/page/order/generate/widget/order_goods.dart';
import 'package:jd_mall_flutter/view/page/order/generate/widget/order_invoice.dart';
import 'package:jd_mall_flutter/view/page/order/generate/widget/order_summation.dart';

class GenerateOrder extends StatelessWidget {
  const GenerateOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        commonHeader(context, title: "填写订单"),
        Expanded(
          flex: 1,
          child: Container(
            color: CommonStyle.colorF5F5F5,
            child: CustomScrollView(
              scrollBehavior: NoShadowScrollBehavior(),
              slivers: [
                defaultAddress(context),
                orderGoods(context),
                orderSummation(context),
                orderInvoice(context),
              ],
            ),
          ),
        ),
        fixedBottom(context)
      ],
    );
  }
}
