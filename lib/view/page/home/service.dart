// Project imports:
import 'package:jd_mall_flutter/config/env_config.dart';
import 'package:jd_mall_flutter/config/global_configs.dart';
import 'package:jd_mall_flutter/http/http.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';

class HomeApi {
  static Future queryHomeInfo() async {
    var res = await httpManager.get('${GlobalConfigs().get(EnvEnum.host.value)}/home/queryHomePageInfo');
    if (res.code != '0') {
      return null;
    }
    return HomePageInfo.fromJson(res.data ?? {});
  }

  static Future queryGoodsListByPage(String code, int currentPage, int pageSize) async {
    var res = await httpManager.post(
      '${GlobalConfigs().get(EnvEnum.host.value)}/home/queryGoodsListByPage',
      params: {"code": code, "currentPage": currentPage, "pageSize": pageSize},
    );
    if (res.code != '0') {
      return null;
    }
    return GoodsPageInfo.fromJson(res.data ?? {});
  }
}
