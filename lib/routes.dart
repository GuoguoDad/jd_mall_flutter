// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:jd_mall_flutter/view/main/main_page.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_page.dart';
import 'package:jd_mall_flutter/view/page/example/Interlaced_animation.dart';
import 'package:jd_mall_flutter/view/page/example/breathing_method.dart';
import 'package:jd_mall_flutter/view/page/example/complete_form.dart';
import 'package:jd_mall_flutter/view/page/example/contact_list.dart';
import 'package:jd_mall_flutter/view/page/example/gesture_spring.dart';
import 'package:jd_mall_flutter/view/page/example/sample_list.dart';
import 'package:jd_mall_flutter/view/page/example/snow_man.dart';
import 'package:jd_mall_flutter/view/page/order/generate/generate_order.dart';
import 'package:jd_mall_flutter/view/page/personal/personal_info.dart';
import 'package:jd_mall_flutter/view/vebview/webview_page.dart';

enum RouteEnum {
  //example
  sampleList("/sampleList"),
  completeForm("/completeForm"),
  interlacedAnimation("/interlacedAnimation"),
  breathingMethod("/breathingMethod"),
  snowMan("/snowMan"),
  gestureSpring("/gestureSpring"),
  contactList("/contactList"),
  //pages
  mainPage("/mainPage"),
  detailPage("/detailPage"),
  generateOrder("/generateOrder"),
  webViewPage("/webViewPage"),
  personalInfo("/personalInfo");

  const RouteEnum(this.path);

  final String path;
}

Map<String, WidgetBuilder> routesMap = {
  //example
  RouteEnum.sampleList.path: (context) => const SampleList(),
  RouteEnum.completeForm.path: (context) => const CompleteForm(),
  RouteEnum.interlacedAnimation.path: (context) => const InterlacedAnimationDemo(),
  RouteEnum.breathingMethod.path: (context) => const BreathingMethod(),
  RouteEnum.snowMan.path: (context) => const SnowManDemo(),
  RouteEnum.gestureSpring.path: (context) => const GestureSpring(),
  RouteEnum.contactList.path: (context) => const ContactList(),
  //pages
  RouteEnum.mainPage.path: (context) => const MainPage(),
  RouteEnum.detailPage.path: (context) => const DetailPage(),
  RouteEnum.generateOrder.path: (context) => const GenerateOrder(),
  RouteEnum.webViewPage.path: (context) => const WebViewPage(),
  RouteEnum.personalInfo.path: (context) => const PersonalInfo(),
};
