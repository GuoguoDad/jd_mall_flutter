import 'package:jd_mall_flutter/common/http/http.dart';
import 'package:jd_mall_flutter/models/second_group_category_info.dart';
import 'package:jd_mall_flutter/config/global_configs.dart';
import 'package:jd_mall_flutter/models/primary_category_list.dart';

class CategoryApi {
  static Future queryCategoryInfo() async {
    var res = await httpManager.get('${GlobalConfigs().get("host")}/category/list', {}, null, null);
    if (res?.code != '0') {
      return null;
    }
    return PrimaryCategoryList.fromJson(res?.data ?? {});
  }

  static Future querySecondGroupCategoryInfo(String categoryId) async {
    var res =
        await httpManager.post('${GlobalConfigs().get("host")}/category/queryContentByCategory', {"categoryId": categoryId}, null, null);
    if (res?.code != '0') {
      return null;
    }
    return SecondGroupCategoryInfo.fromJson(res?.data ?? {});
  }
}
