// Project imports:
import 'package:jd_mall_flutter/config/env_config.dart';
import 'package:jd_mall_flutter/config/global_configs.dart';
import 'package:jd_mall_flutter/http/http.dart';
import 'package:jd_mall_flutter/models/login_response.dart';

class LoginApi {
  static Future login(String userName, String password) async {
    var res = await httpManager.post('${GlobalConfigs().get(EnvEnum.host.value)}/common/login', params: {"userName": userName, "password": password});
    if (res.code != '0') {
      return null;
    }
    return LoginResponse.fromJson(res.data ?? {});
  }
}
