import 'package:jd_mall_flutter/common/http/http.dart';
import 'package:jd_mall_flutter/models/cart_goods.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/common/config/config.dart';

class CartApi {
  static Future queryCartGoods() async {
    var res = await httpManager.post('${config.host}/cart/queryCartGoodsList', null, null, null);
    if (res?.code != '0') {
      return null;
    }
    return (res?.data as List<dynamic>?)?.map((e) => CartGoods.fromJson(e as Map<String, dynamic>)).toList() ?? [];
  }

  static Future queryGoodsListByPage(int currentPage, int pageSize) async {
    var res =
        await httpManager.post('${config.host}/cart/queryMaybeLikeList', {"currentPage": currentPage, "pageSize": pageSize}, null, null);
    if (res?.code != '0') {
      return null;
    }
    return GoodsPageInfo.fromJson(res?.data ?? {});
  }
}
