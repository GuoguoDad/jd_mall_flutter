import 'package:jd_mall_flutter/common/http/http.dart';
import 'package:jd_mall_flutter/common/config/config.dart';
import 'package:jd_mall_flutter/models/second_group_category_info.dart';
import '../../models/primary_category_list.dart';

class CategoryApi {
  static Future queryCategoryInfo() async {
    var res = await httpManager.get('${config.host}/category/list', {}, null, null);
    return PrimaryCategoryList.fromJson(res?.data);
  }

  static Future querySecondGroupCategoryInfo(String categoryId) async {
    var res = await httpManager.post('${config.host}/category/queryContentByCategory', {"categoryId": categoryId}, null, null);
    return SecondGroupCategoryInfo.fromJson(res?.data);
  }
}
