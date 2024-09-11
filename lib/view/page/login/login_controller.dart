// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/extension/get_router_navigation_ext.dart';
import 'package:jd_mall_flutter/common/global/Global.dart';
import 'package:jd_mall_flutter/common/util/util.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/page/login/service.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  RxBool hasLogin = false.obs;

  RxBool showPassword = false.obs;

  final formKey = GlobalKey<FormBuilderState>();

  setLogin(bool va) => hasLogin.value = va;

  setShowPassword(bool va) => showPassword.value = va;

  @override
  void onInit() {
    hasLogin.value = isLogin();
    super.onInit();
  }

  Future<void> login() async {
    if (formKey.currentState!.saveAndValidate()) {
      var userName = formKey.currentState?.value['userName'];
      var password = formKey.currentState?.value['password'];

      var res = await LoginApi.login(userName, password);

      if (res != null) {
        hasLogin.value = true;
        await Global.preferences!.setString("loginFlag", "LoggedIn");
        await Global.preferences!.setString("token", res.token);
        await Global.preferences!.setString("userId", res.userId);
        await Global.preferences!.setString("userName", res.userName);
        await Global.preferences!.setString("headerImg", res.headerImg);
        await Global.preferences!.setString("integral", res.integral.toString());
        await Global.preferences!.setString("creditValue", res.creditValue.toString());

        if (Get.arguments != null) {
          var from = Get.arguments["from"];
          var args = Get.arguments["args"];
          Get.popNamedSingleTask(from, arguments: args);
        } else {
          Get.popNamedSingleTask(RoutesEnum.mainPage.path);
        }
      }
    }
  }
}
