import 'package:jd_mall_flutter/models/goods_detail_res.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/types/common.dart';

class InitPageAction {
  InitPageAction();
}

class SetLoadingAction {
  final bool value;

  SetLoadingAction(this.value);
}

//记录页面滚动距离
class ChangePageScrollYAction {
  final double value;

  ChangePageScrollYAction(this.value);
}

class ChangeTopTabIndexAction {
  final int index;

  ChangeTopTabIndexAction(this.index);
}

class InitCurrentGoodsInfoAction {
  final GoodsDetailRes goodsDetailRes;

  final BannerInfo selectInfo;

  InitCurrentGoodsInfoAction(this.goodsDetailRes, this.selectInfo);
}

class ChangeCurrentInfoAction {
  final BannerInfo selectInfo;

  ChangeCurrentInfoAction(this.selectInfo);
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
