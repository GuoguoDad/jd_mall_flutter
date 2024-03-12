// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/util.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  RxBool hasLogin = false.obs;

  RxBool showPassword = false.obs;

  setLogin(bool va) => hasLogin.value = va;

  setShowPassword(bool va) => showPassword.value = va;

  @override
  void onInit() {
    hasLogin.value = isLogin();
    super.onInit();
  }
}
