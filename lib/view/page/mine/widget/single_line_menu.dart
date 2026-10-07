// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/component/page_menu.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/view/page/mine/mine_provider.dart';

class SingleLineMenu extends StatelessWidget {
  const SingleLineMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<MineProvider, List<FunctionInfo>>(
      selector: (context, provider) => provider.menuTabInfo.functionList ?? const <FunctionInfo>[],
      shouldRebuild: (prev, next) => !identical(prev, next),
      builder: (context, menuData, child) {
        return SliverToBoxAdapter(
          child: PageMenu(menuDataList: menuData),
        );
      }
    );
  }
}
