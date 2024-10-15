// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/component/image/extend_image_network.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/page/home/home_controller.dart';

Widget advBanner() {
  return SliverToBoxAdapter(
    child: GestureDetector(
      onTap: () => Get.toNamed(
        RoutesEnum.webViewPage.path,
        arguments: {"url": "https://pro.m.jd.com/mall/active/2WrXYwmYpiy7EpWjDETSVyhXfLCb/index.html"},
      ),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(0),
        child: Obx(
          () => ExtendImageNetwork(
            url: HomeController.to.homePageInfo.value.adUrl ?? "",
            height: 90,
            cache: true,
            fit: BoxFit.fill,
          )
        ),
      ),
    ),
  );
}
