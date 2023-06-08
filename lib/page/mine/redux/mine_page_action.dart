import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';

//记录页面滚动距离
class ChangePageScrollYAction {
  final double value;

  ChangePageScrollYAction(this.value);
}

//滚动菜单滚动页面索引
class ChangeSliderIndexAction {
  final int menuIndex;

  ChangeSliderIndexAction(this.menuIndex);
}

class InitPageAction {
  InitPageAction();
}

class InitMineMenuTabInfoAction {
  final MineMenuTabInfo menuTabInfo;

  InitMineMenuTabInfoAction(this.menuTabInfo);
}
