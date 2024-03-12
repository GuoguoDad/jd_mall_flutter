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

//商品、评论、详情、同店好货锚点key
final cardKeys = <GlobalKey>[
  GlobalKey(debugLabel: 'detail_card_0'),
  GlobalKey(debugLabel: 'detail_card_1'),
  GlobalKey(debugLabel: 'detail_card_2'),
  GlobalKey(debugLabel: 'detail_card_3')
];
