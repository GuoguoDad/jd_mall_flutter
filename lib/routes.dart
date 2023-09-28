// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:jd_mall_flutter/view/main/main_page.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_page.dart';
import 'package:jd_mall_flutter/view/page/example/Interlaced_animation.dart';
import 'package:jd_mall_flutter/view/page/example/breathing_method.dart';
import 'package:jd_mall_flutter/view/page/example/complete_form.dart';
import 'package:jd_mall_flutter/view/page/example/gesture_spring.dart';
import 'package:jd_mall_flutter/view/page/example/sample_list.dart';
import 'package:jd_mall_flutter/view/page/example/snow_man.dart';
import 'package:jd_mall_flutter/view/page/order/generate/generate_order.dart';
import 'package:jd_mall_flutter/view/vebview/webview_page.dart';

enum PageRouteEnum {
  //example
  sampleList("/sampleList"),
  completeForm("/completeForm"),
  interlacedAnimation("/interlacedAnimation"),
  breathingMethod("/breathingMethod"),
  snowMan("/snowMan"),
  gestureSpring("gestureSpring"),
  //pages
  mainPage("/mainPage"),
  detailPage("/detailPage"),
  generateOrder("/generateOrder"),
  webViewPage("/webViewPage");

  const PageRouteEnum(this.path);

  final String path;
}

Map<String, WidgetBuilder> routesMap = {
  //example
  PageRouteEnum.sampleList.path: (context) => const SampleList(),
  PageRouteEnum.completeForm.path: (context) => const CompleteForm(),
  PageRouteEnum.interlacedAnimation.path: (context) => const InterlacedAnimationDemo(),
  PageRouteEnum.breathingMethod.path: (context) => const BreathingMethod(),
  PageRouteEnum.snowMan.path: (context) => const SnowManDemo(),
  PageRouteEnum.gestureSpring.path: (context) => const GestureSpring(),
  //pages
  PageRouteEnum.mainPage.path: (context) => const MainPage(),
  PageRouteEnum.detailPage.path: (context) => const DetailPage(),
  PageRouteEnum.generateOrder.path: (context) => const GenerateOrder(),
  PageRouteEnum.webViewPage.path: (context) => const WebViewPage(),
};
