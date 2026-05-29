// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Project imports:
import 'package:jd_mall_flutter/common/extension/get_router_navigation_ext.dart';
import 'package:jd_mall_flutter/common/global/Global.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/page/login/service.dart';

class LoginProvider extends ChangeNotifier {
  bool hasLogin = false;

  bool showPassword = false;

  final formKey = GlobalKey<FormBuilderState>();

  void setLogin(bool va) {
    hasLogin = va;
    notifyListeners();
  }

  void setShowPassword(bool va) {
    showPassword = va;
    notifyListeners();
  }

  Future<void> login() async {
    if (formKey.currentState!.saveAndValidate()) {
      var userName = formKey.currentState?.value['userName'];
      var password = formKey.currentState?.value['password'];

      var res = await LoginApi.login(userName, password);

      if (res != null) {
        hasLogin = true;
        await Global.preferences!.setString("loginFlag", "LoggedIn");
        await Global.preferences!.setString("token", res.token);
        await Global.preferences!.setString("userId", res.userId);
        await Global.preferences!.setString("userName", res.userName);
        await Global.preferences!.setString("headerImg", res.headerImg);
        await Global.preferences!.setString("integral", res.integral.toString());
        await Global.preferences!.setString("creditValue", res.creditValue.toString());
      }
    }
  }
}
