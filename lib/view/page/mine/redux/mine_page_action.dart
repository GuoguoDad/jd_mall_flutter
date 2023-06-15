import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';

import '../../../../models/goods_page_info.dart';

import 'package:jd_mall_flutter/types/common.dart';

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

//商品数据
class InitGoodsPageAction {
  final int pageNum;
  final GoodsPageInfo value;

  InitGoodsPageAction(this.pageNum, this.value);
}

//商品数据
class MoreGoodsPageAction {
  final int pageNum;
  final GoodsPageInfo value;

  MoreGoodsPageAction(this.pageNum, this.value);
}

//商品瀑布流列表加载更多
class LoadMoreAction {
  late int currentPage;
  late VoidCallback loadMoreSuccess;
  late VoidCallback loadMoreFail;

  LoadMoreAction(this.currentPage, this.loadMoreSuccess, this.loadMoreFail);
}
