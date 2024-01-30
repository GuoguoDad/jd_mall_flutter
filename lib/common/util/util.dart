// Package imports:
import 'package:url_launcher/url_launcher.dart';

import 'package:jd_mall_flutter/common/global/Global.dart';

Future<bool> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  if (await canLaunchUrl(launchUri)) {
    return launchUrl(launchUri);
  } else {
    throw 'Could not launch';
  }
}

bool isLogin() {
  bool isLogin = true;
  var loginFlag = Global.preferences!.getString("loginFlag");
  if (loginFlag == null || loginFlag.isEmpty) {
    isLogin = false;
  }
  return isLogin;
}
