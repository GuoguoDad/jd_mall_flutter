import 'package:jd_mall_flutter/models/cart_goods.dart';
import '../../../models/goods_page_info.dart';

class CartPageState {
  List<CartGoods> cartGoods;

  int pageNum = 1;

  //商品数据
  GoodsPageInfo goodsPageInfo;

  CartPageState(this.cartGoods, this.pageNum, this.goodsPageInfo);
}
