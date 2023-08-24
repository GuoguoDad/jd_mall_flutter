// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:jd_mall_flutter/view/main/main_page.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_page.dart';
import 'package:jd_mall_flutter/view/page/example/Interlaced_animation.dart';
import 'package:jd_mall_flutter/view/page/example/breathing_method.dart';
import 'package:jd_mall_flutter/view/page/example/snow_man.dart';
import 'package:jd_mall_flutter/view/page/order/generate/generate_order.dart';
import 'package:jd_mall_flutter/view/vebview/webview_page.dart';
import 'package:jd_mall_flutter/view/page/example/sample_list.dart';

Map<String, WidgetBuilder> routesMap = {
  //example
  SampleList.name: (context) => const SampleList(),
  InterlacedAnimationDemo.name: (context) => const InterlacedAnimationDemo(),
  BreathingMethod.name: (context) => const BreathingMethod(),
  SnowManDemo.name: (context) => const SnowManDemo(),
  //pages
  MainPage.name: (context) => const MainPage(),
  DetailPage.name: (context) => const DetailPage(),
  GenerateOrder.name: (context) => const GenerateOrder(),
  WebViewPage.name: (context) => const WebViewPage(),
};
