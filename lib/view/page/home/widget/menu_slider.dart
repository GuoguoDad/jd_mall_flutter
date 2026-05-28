// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/component/page_menu.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/view/page/home/home_provider.dart';

class MenuSlider extends StatelessWidget {
  const MenuSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          List<NineMenuList> nineMenuList = provider.homePageInfo.nineMenuList ?? [];

          return PageMenu(
            menuDataList: nineMenuList
                .map((e) => FunctionInfo(
              menuIcon: e.menuIcon,
              menuCode: e.menuCode,
              menuName: e.menuName,
              h5url: e.h5url,
            ))
                .toList(),
            rowCount: 2,
          );
        }
      ),
    );
  }
}
