import 'package:jd_mall_flutter/common/http/http.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/common/config/config.dart';
import 'package:jd_mall_flutter/models/goods_detail_res.dart';

class DetailApi {
  static Future queryDetailInfo() async {
    var res = await httpManager.get('${config.host}/detail/queryGoodsDetail', {}, null, null);
    if (res?.code != '0') {
      return null;
    }
    return GoodsDetailRes.fromJson(res?.data ?? {});
  }

  static Future queryStoreGoodsListByPage(int currentPage, int pageSize) async {
    var res =
        await httpManager.post('${config.host}/detail/queryStoreGoodsList', {"currentPage": currentPage, "pageSize": pageSize}, null, null);
    if (res?.code != '0') {
      return null;
    }
    return GoodsPageInfo.fromJson(res?.data ?? {});
  }
}
