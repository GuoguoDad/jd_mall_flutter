import 'package:jd_mall_flutter/http/http.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/config/global_configs.dart';
import 'package:jd_mall_flutter/config/env_config.dart';

class CommonServiceApi {
  static Future queryGoodsListByPage(String code, int currentPage, int pageSize) async {
    var res = await httpManager.post('${GlobalConfigs().get(EnvKey.host.value)}/common/queryGoodsListByPage',
        params: {"code": code, "currentPage": currentPage, "pageSize": pageSize});
    if (res?.code != '0') {
      return null;
    }
    return GoodsPageInfo.fromJson(res?.data ?? {});
  }
}
