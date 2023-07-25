// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:jd_mall_flutter/component/page_menu.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/store/app_state.dart';

Widget singleLineMenu(BuildContext context) {
  return StoreBuilder<AppState>(
    builder: (context, store) {
      List<FunctionInfo> menuData = store.state.minePageState.menuTabInfo.functionList ?? [];

      return PageMenu(menuDataList: menuData);
    },
  );
}
