// Project imports:
import 'package:jd_mall_flutter/models/cart_goods.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';

class CartPageState {
  bool isLoading = true;

  List<CartGoods> cartGoods;

  List<String> selectCartGoodsList;

  int pageNum = 1;

  //商品数据
  GoodsPageInfo goodsPageInfo;

  CartPageState(this.isLoading, this.cartGoods, this.pageNum, this.goodsPageInfo, this.selectCartGoodsList);
}
