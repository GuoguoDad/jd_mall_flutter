// Flutter imports:
import 'dart:ui';

import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/global/Global.dart';

double getScreenHeight() {
  return MediaQuery.sizeOf(Global.navigatorKey.currentContext!).height;
}

double getScreenWidth() {
  return MediaQuery.sizeOf(Global.navigatorKey.currentContext!).width;
}

double getStatusHeight() {
  return MediaQuery.viewPaddingOf(Global.navigatorKey.currentContext!).top;
  // return MediaQueryData.fromView(PlatformDispatcher.instance.views.first).padding.top;
}

double getBottomSpace() {
  return MediaQuery.viewPaddingOf(Global.navigatorKey.currentContext!).bottom;
}

double getKeyboardHeight() {
  return MediaQuery.viewInsetsOf(Global.navigatorKey.currentContext!).bottom;
}

double getSafeAreaHeight() {
  return getScreenHeight() - getStatusHeight() - getBottomSpace();
}

/// 获取底部getBottomNavigationBarHeight高度 包含 bottomSpace
double getBottomNavigationBarHeight() {
  return kBottomNavigationBarHeight + getBottomSpace();
}
