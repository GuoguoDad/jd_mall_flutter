// Project imports:
import 'package:jd_mall_flutter/config/env_config.dart';
import 'package:jd_mall_flutter/config/global_configs.dart';
import 'package:jd_mall_flutter/http/http.dart';
import 'package:jd_mall_flutter/models/goods_detail_res.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';

class DetailApi {
  static Future queryDetailInfo() async {
    var res = await httpManager.get('${GlobalConfigs().get(EnvEnum.host.value)}/detail/queryGoodsDetail');
    if (res.code != '0') {
      return null;
    }
    return GoodsDetailRes.fromJson(res.data ?? {});
  }

  static Future queryStoreGoodsListByPage(int currentPage, int pageSize) async {
    var res = await httpManager.post(
      '${GlobalConfigs().get(EnvEnum.host.value)}/detail/queryStoreGoodsList',
      params: {"currentPage": currentPage, "pageSize": pageSize},
    );
    if (res.code != '0') {
      return null;
    }
    return GoodsPageInfo.fromJson(res.data ?? {});
  }
}
