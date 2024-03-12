// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/util.dart';

class LoginController extends GetxController {
  RxBool hasLogin = false.obs;

  setLogin(bool va) => hasLogin.value = va;

  @override
  void onInit() {
    hasLogin.value = isLogin();
    super.onInit();
  }
}
