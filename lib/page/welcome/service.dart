import 'package:jd_mall_flutter/common/http/http.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/common/config/config.dart';

class WelcomeApi {
  static Future queryHomeInfo() async {
    var res = await httpManager.get('${config.host}/welcome/queryHomePageInfo', {}, null, null);
    return HomePageInfo.fromJson(res?.data);
  }
}