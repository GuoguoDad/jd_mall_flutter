// Project imports:
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';

class MinePageState {
  bool isLoading = true;

  //横向滚动菜单PageView索引
  int menuIndex;

  //当前选中的分类tab
  String currentTab = "1";

  MineMenuTabInfo menuTabInfo;

  MinePageState(this.isLoading, this.menuIndex, this.currentTab, this.menuTabInfo);
}
