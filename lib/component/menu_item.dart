// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/component/image/extend_image_network.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
    this.menuData, {
    super.key,
  });

  final FunctionInfo menuData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if ((menuData.h5url ?? "").isNotEmpty) {
          Get.toNamed(RoutesEnum.webViewPage.path, arguments: {"url": menuData.h5url.toString()});
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ExtendImageNetwork(url: menuData.menuIcon.toString(),
            width: 40,
            height: 40,
            cache: true,
            fit: BoxFit.cover,
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              menuData.menuName.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
