// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
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
  videoPlayer('videoPlayer'),
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

var loginRequiredRoutes = [RoutesEnum.personalInfo.path, RoutesEnum.generateOrder.path];

Map<String, WidgetBuilder> routesMap = {
  //example
  RoutesEnum.sampleList.path: (context) => const SampleList(),
  RoutesEnum.completeForm.path: (context) => const CompleteForm(),
  RoutesEnum.interlacedAnimation.path: (context) => const InterlacedAnimationDemo(),
  RoutesEnum.breathingMethod.path: (context) => const BreathingMethod(),
  RoutesEnum.snowMan.path: (context) => const SnowManDemo(),
  RoutesEnum.gestureSpring.path: (context) => const GestureSpring(),
  RoutesEnum.contactList.path: (context) => const ContactList(),
  RoutesEnum.filePreview.path: (context, {arguments}) => FilePreviewPage(arguments: arguments),
  RoutesEnum.videoPlayer.path: (context) => const VideoPlayerDemo(),
  //pages
  RoutesEnum.mainPage.path: (context) => const MainPage(),
  RoutesEnum.detailPage.path: (context) => DetailPage(),
  RoutesEnum.webViewPage.path: (context, {arguments}) => WebViewPage(arguments: arguments),
  RoutesEnum.generateOrder.path: (context) => const GenerateOrder(),
  RoutesEnum.personalInfo.path: (context) => const PersonalInfo(),
  RoutesEnum.loginPage.path: (context, {arguments}) => LoginPage(arguments: arguments),
  RoutesEnum.notFound.path: (context) => const Page404(),
};
