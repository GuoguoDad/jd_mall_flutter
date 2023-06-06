import '../../../models/cart_goods.dart';
import '../../../models/goods_page_info.dart';

typedef VoidCallback = void Function();

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

class SelectCartGoodsAction {
  final String goodsCode;

  SelectCartGoodsAction(this.goodsCode);
}

class SelectStoreGoodsAction {
  final String storeCode;
  final bool value;
  SelectStoreGoodsAction(this.storeCode, this.value);
}

class SelectAllAction {
  bool selectAll;

  SelectAllAction(this.selectAll);
}
