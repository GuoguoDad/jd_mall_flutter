import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';

//记录页面滚动距离
class ChangePageScrollYAction {
  final double value;
  ChangePageScrollYAction(this.value);
}

//滚动菜单滚动页面索引
class SetMenuSliderIndex {
  final int value;
  SetMenuSliderIndex(this.value);
}

//滚动tab当前选中项
class SetCurrentTab {
  final String value;
  SetCurrentTab(this.value);
}

//页面初始化
class InitDataAction {
  InitDataAction();
}

//页面刷新
typedef OnFreshSuccess = void Function();
typedef OnFreshFail = void Function();
class RefreshAction {
  late OnFreshSuccess freshSuccess;
  late OnFreshFail freshFail;
  RefreshAction(this.freshSuccess, this.freshFail);
}

//首页数据
class SetHomePageInfoAction {
  final HomePageInfo value;
  SetHomePageInfoAction(this.value);
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
typedef OnLoadMoreSuccess = void Function();
typedef OnLoadMoreFail = void Function();
class LoadMoreAction {
  late int currentPage;
  late OnLoadMoreSuccess loadMoreSuccess;
  late OnLoadMoreFail loadMoreFail;
  LoadMoreAction(this.currentPage, this.loadMoreSuccess, this.loadMoreFail);
}
