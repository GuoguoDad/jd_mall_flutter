import 'package:jd_mall_flutter/common/http/http.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/common/config/config.dart';
import '../../models/primary_category_list.dart';

class CategoryApi {
  static Future queryCategoryInfo() async {
    var res = await httpManager.get('${config.host}/category/list', {}, null, null);
    return PrimaryCategoryList.fromJson(res?.data);
  }

  static Future queryGoodsListByPage(int currentPage, int pageSize) async {
    var res = await httpManager.post(
        '${config.host}/welcome/queryGoodsListByPage', {"currentPage": currentPage, "pageSize": pageSize}, null, null);
    return GoodsPageInfo.fromJson(res?.data);
  }
}
