import 'package:jd_mall_flutter/common/http/http.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/common/config/config.dart';

class WelcomeApi {
  static Future queryHomeInfo() async {
    var res = await httpManager.get('${config.host}/welcome/queryHomePageInfo', {}, null, null);
    if (res?.code != '0') {
      return null;
    }
    return HomePageInfo.fromJson(res?.data ?? {});
  }

  static Future queryGoodsListByPage(int currentPage, int pageSize) async {
    var res = await httpManager.post(
        '${config.host}/welcome/queryGoodsListByPage', {"currentPage": currentPage, "pageSize": pageSize}, null, null);
    if (res?.code != '0') {
      return null;
    }
    return GoodsPageInfo.fromJson(res?.data ?? {});
  }
}
