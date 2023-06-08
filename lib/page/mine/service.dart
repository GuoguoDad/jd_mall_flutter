import 'package:jd_mall_flutter/common/http/http.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/common/config/config.dart';

import '../../models/mine_menu_tab_info.dart';

class MineApi {
  static Future queryInfo() async {
    var res = await httpManager.get('${config.host}/mine/queryMineInfo', {}, null, null);
    if (res?.code != '0') {
      return null;
    }
    return MineMenuTabInfo.fromJson(res?.data ?? {});
  }

  static Future queryRecommendList(int currentPage, int pageSize) async {
    var res =
        await httpManager.post('${config.host}/mine/queryRecommendList', {"currentPage": currentPage, "pageSize": pageSize}, null, null);
    if (res?.code != '0') {
      return null;
    }
    return GoodsPageInfo.fromJson(res?.data ?? {});
  }
}
