import 'package:jd_mall_flutter/models/cart_goods.dart';
import '../../../models/goods_page_info.dart';

class CartPageState {
  bool isLoading = true;

  List<CartGoods> cartGoods;

  int pageNum = 1;

  //商品数据
  GoodsPageInfo goodsPageInfo;

  CartPageState(this.isLoading, this.cartGoods, this.pageNum, this.goodsPageInfo);
}
