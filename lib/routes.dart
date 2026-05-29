// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/middleware/auth_middleware.dart';
import 'package:jd_mall_flutter/view/main/main_page.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_page.dart';
import 'package:jd_mall_flutter/view/page/example/Interlaced_animation.dart';
import 'package:jd_mall_flutter/view/page/example/breathing_method.dart';
import 'package:jd_mall_flutter/view/page/example/complete_form.dart';
import 'package:jd_mall_flutter/view/page/example/contact_list.dart';
import 'package:jd_mall_flutter/view/page/example/file_preview.dart';
import 'package:jd_mall_flutter/view/page/example/gesture_spring.dart';
import 'package:jd_mall_flutter/view/page/example/sample_list.dart';
import 'package:jd_mall_flutter/view/page/example/snow_man.dart';
import 'package:jd_mall_flutter/view/page/example/video_simple.dart';
import 'package:jd_mall_flutter/view/page/login/login_page.dart';
import 'package:jd_mall_flutter/view/page/order/generate/generate_order.dart';
import 'package:jd_mall_flutter/view/page/personal/personal_info.dart';
import 'package:jd_mall_flutter/view/system/page404.dart';
import 'package:jd_mall_flutter/view/vebview/webview_page.dart';

enum RoutesEnum {
  //example
  sampleList("/sampleList"),
  completeForm("/completeForm"),
  interlacedAnimation("/interlacedAnimation"),
  breathingMethod("/breathingMethod"),
  snowMan("/snowMan"),
  gestureSpring("/gestureSpring"),
  contactList("/contactList"),
  filePreview("/filePreview"),
  videoPlayer('/videoPlayer'),
  //pages
  mainPage("/mainPage"),
  detailPage("/detailPage"),
  webViewPage("/webViewPage"),
  loginPage("/loginPage"),
  generateOrder("/generateOrder"),
  personalInfo("/personalInfo"),
  notFound("/notFound");

  const RoutesEnum(this.path);

  final String path;
}

Map<String, WidgetBuilder> routesMap = {
  //example
  RoutesEnum.sampleList.path.toString(): (context) =>  const SampleList(),
  RoutesEnum.completeForm.path.toString(): (context) =>  const CompleteForm(),
  RoutesEnum.interlacedAnimation.path.toString(): (context) => const InterlacedAnimationDemo(),
  RoutesEnum.breathingMethod.path.toString(): (context) => const BreathingMethod(),
  RoutesEnum.snowMan.path.toString(): (context) => const SnowManDemo(),
  RoutesEnum.gestureSpring.path.toString(): (context) => const GestureSpring(),
  RoutesEnum.contactList.path.toString(): (context) => const ContactList(),
  // RoutesEnum.filePreview.path.toString(): (context) => const FilePreviewPage(),
  RoutesEnum.videoPlayer.path.toString(): (context) => const VideoPlayerDemo(),
  //pages
  RoutesEnum.mainPage.path.toString(): (context) => const MainPage(),
  RoutesEnum.detailPage.path.toString(): (context) => const DetailPage(),
  RoutesEnum.webViewPage.path.toString(): (context) => const WebViewPage(),
  RoutesEnum.generateOrder.path.toString(): (context) => const GenerateOrder(),
  RoutesEnum.personalInfo.path.toString(): (context) => const PersonalInfo(),
  RoutesEnum.loginPage.path.toString(): (context) => const LoginPage(),
};
