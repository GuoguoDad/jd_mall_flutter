import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';

double calc2Top(double scrollY) {
  double result = 45;
  if (scrollY > 0 && scrollY <= 45) {
    result -= scrollY * 0.92;
  } else if (scrollY <= 0) {
    result = 45;
  } else {
    result = 45 * 0.08;
  }
  return result;
}

double calcWidth(double scrollY) {
  double result = 32;
  if (scrollY > 0 && scrollY <= 45) {
    result += scrollY * 2;
  } else if (scrollY <= 0) {
    result = 32;
  } else {
    result = 45 * 2 + 32;
  }
  return result;
}

Header classicHeader = const ClassicHeader(
  clamping: true,
  position: IndicatorPosition.locator,
  mainAxisAlignment: MainAxisAlignment.end,
  dragText: '下拉刷新',
  armedText: '松开开始刷新数据',
  readyText: '刷新中...',
  processingText: '刷新中...',
  processedText: '刷新成功',
  messageText: '最后更新时间 %T',
);
