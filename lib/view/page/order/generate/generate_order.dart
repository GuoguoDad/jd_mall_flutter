// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/component/common_header.dart';
import 'package:jd_mall_flutter/view/page/order/generate/widget/bottom.dart';
import 'package:jd_mall_flutter/view/page/order/generate/widget/default_address.dart';

class GenerateOrder extends StatefulWidget {
  const GenerateOrder({super.key});

  static const String name = "/generateOrder";

  @override
  State<StatefulWidget> createState() => _GenerateOrderState();
}

class _GenerateOrderState extends State<GenerateOrder> {
  @override
  void initState() {
    super.initState();
  }

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
              slivers: [
                defaultAddress(context),
              ],
            ),
          ),
        ),
        fixedBottom(context)
      ],
    );
  }
}
