// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static SharedPreferences? preferences;

  static void initPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }
}
