import '../../../models/mine_menu_tab_info.dart';

class MinePageState {
  //滚动条位置
  double pageScrollY;

  //横向滚动菜单PageView索引
  int menuIndex;

  MineMenuTabInfo menuTabInfo;

  MinePageState(this.pageScrollY, this.menuIndex, this.menuTabInfo);
}
