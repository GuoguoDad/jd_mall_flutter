// Package imports:
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

// Project imports:
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

/// 函数防抖
///
/// [func]: 要执行的方法
/// [delay]: 要迟延的时长
/// Center(
//     child: RaisedButton.icon(
//       icon: Icon(Icons.add),
//       label: Text('防抖'),
//       onPressed: debounce(() {
//         if (!mounted) {
//           return;
//         }
//         setState(() {
//           _count++;
//         });
//       }),
//     ),
//   )
Function debounce(
  Function func, [
  Duration delay = const Duration(milliseconds: 2000),
]) {
  Timer? timer;
  target() {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(delay, () {
      func.call();
    });
  }

  return target;
}

/// 函数节流
/// [func]: 要执行的方法
/// Center(
//   child: RaisedButton.icon(
//     icon: Icon(Icons.add),
//     label: Text('节流，耗时操作2s'),
//     onPressed: throttle(() async {
//       await Future.delayed(Duration(milliseconds: 2000));
//       if (!mounted) {
//         return;
//       }
//       setState(() {
//         _count++;
//       });
//     }),
//   ),
// ),
///
Function throttle(
  Future Function() func,
) {
  bool enable = true;
  target() {
    if (enable == true) {
      enable = false;
      func().then((_) {
        enable = true;
      });
    }
  }

  return target;
}
