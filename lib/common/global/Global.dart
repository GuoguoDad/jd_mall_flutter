// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  //定义一个全局的 sp
  static SharedPreferences? preferences;

  //初始化
  static void initPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }
}
