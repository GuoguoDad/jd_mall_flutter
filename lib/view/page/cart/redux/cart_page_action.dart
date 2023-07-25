import 'package:jd_mall_flutter/models/cart_goods.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/types/common.dart';

class InitAction {
  InitAction();
}

//记录页面滚动距离
class SetLoadingAction {
  final bool value;

  SetLoadingAction(this.value);
}

class InitCartGoodsAction {
  List<CartGoods> cartGoods;

  InitCartGoodsAction(this.cartGoods);
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

//单独选中购物车中商品
class SelectCartGoodsAction {
  final String goodsCode;

  SelectCartGoodsAction(this.goodsCode);
}

//购物车修改商品数量
class ChangeCartGoodsNumAction {
  final String goodsCode;
  final int num;

  ChangeCartGoodsNumAction(this.goodsCode, this.num);
}

//选中店铺
class SelectStoreGoodsAction {
  final String storeCode;
  final bool value;

  SelectStoreGoodsAction(this.storeCode, this.value);
}

//全选
class SelectAllAction {
  bool selectAll;

  SelectAllAction(this.selectAll);
}
