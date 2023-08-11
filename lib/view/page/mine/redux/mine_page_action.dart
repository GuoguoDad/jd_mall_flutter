// Project imports:
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/types/common.dart';

class SetLoadingAction {
  final bool value;

  SetLoadingAction(this.value);
}

//滚动菜单滚动页面索引
class ChangeSliderIndexAction {
  final int menuIndex;

  ChangeSliderIndexAction(this.menuIndex);
}

//滚动tab当前选中项
class SetCurrentTab {
  final String value;

  SetCurrentTab(this.value);
}

class InitPageAction {
  InitPageAction();
}

class InitMineMenuTabInfoAction {
  final MineMenuTabInfo menuTabInfo;

  InitMineMenuTabInfoAction(this.menuTabInfo);
}

//页面刷新
class RefreshAction {
  late VoidCallback freshSuccess;
  late VoidCallback freshFail;

  RefreshAction(this.freshSuccess, this.freshFail);
}
