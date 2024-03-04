// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static SharedPreferences? preferences;

  static Future<void> initPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }
}
