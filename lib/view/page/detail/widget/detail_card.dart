// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/extend_image_network.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_controller.dart';
import 'package:jd_mall_flutter/view/page/home/util.dart';

Widget detailCard(BuildContext context) {
  double screenWidth = getScreenWidth();

  return SliverToBoxAdapter(
    child: Obx(
      () {
        List<String>? introductionList = DetailController.to.goodsDetailRes.value.detailInfo?.introductionList ?? [];

        return Container(
          key: cardKeys[2],
          margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "详情",
                  style: TextStyle(color: CommonStyle.color545454),
                ),
              ),
              Column(
                children: introductionList
                    .map((url) => ExtendImageNetwork(url: url,
                      width: screenWidth - 40,
                      cache: true,
                      fit: BoxFit.fitWidth,
                    ))
                    .toList(),
              )
            ],
          ),
        );
      },
    ),
  );
}
