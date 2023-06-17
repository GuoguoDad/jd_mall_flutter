import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';

class MinePageState {
  bool showBackTop;

  //滚动条位置
  double pageScrollY;

  //横向滚动菜单PageView索引
  int menuIndex;

  //当前选中的分类tab
  String currentTab = "1";

  MineMenuTabInfo menuTabInfo;

  MinePageState(this.showBackTop, this.pageScrollY, this.menuIndex, this.currentTab, this.menuTabInfo);
}
