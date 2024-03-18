// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/vebview/type.dart';

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
          CachedNetworkImage(
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            imageUrl: menuData.menuIcon.toString(),
            placeholder: (context, url) => assetImage("images/default.png", 40, 40),
            errorWidget: (context, url, error) => assetImage("images/default.png", 40, 40),
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
