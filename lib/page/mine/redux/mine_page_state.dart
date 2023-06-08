import '../../../models/goods_page_info.dart';
import '../../../models/mine_menu_tab_info.dart';

class MinePageState {
  //滚动条位置
  double pageScrollY;

  //横向滚动菜单PageView索引
  int menuIndex;

  //当前选中的分类tab
  String currentTab = "1";

  MineMenuTabInfo menuTabInfo;

  int pageNum = 1;

  //商品数据
  GoodsPageInfo goodsPageInfo;

  MinePageState(this.pageScrollY, this.menuIndex, this.currentTab, this.menuTabInfo, this.pageNum, this.goodsPageInfo);
}
