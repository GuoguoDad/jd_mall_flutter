// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/component/page_menu.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import '../home_controller.dart';

Widget menuSlider(BuildContext context) {
  return SliverToBoxAdapter(
    child: Obx(() {
      List<NineMenuList> nineMenuList = HomeController.to.homePageInfo.value.nineMenuList ?? [];
      List<FunctionInfo> menuData = nineMenuList
          .map((e) => FunctionInfo(
                menuIcon: e.menuIcon,
                menuCode: e.menuCode,
                menuName: e.menuName,
                h5url: e.h5url,
              ))
          .toList();

      return PageMenu(
        menuDataList: menuData,
        rowCount: 2,
      );
    }),
  );
}
