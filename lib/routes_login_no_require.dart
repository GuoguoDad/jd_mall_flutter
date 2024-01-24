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
import 'package:jd_mall_flutter/view/page/login/login_page.dart';
import 'package:jd_mall_flutter/view/system/page404.dart';
import 'package:jd_mall_flutter/view/vebview/webview_page.dart';

enum NoLoginRequiredRouteEnum {
  //example
  sampleList("/sampleList"),
  completeForm("/completeForm"),
  interlacedAnimation("/interlacedAnimation"),
  breathingMethod("/breathingMethod"),
  snowMan("/snowMan"),
  gestureSpring("/gestureSpring"),
  contactList("/contactList"),
  filePreview("/filePreview"),
  //pages
  mainPage("/mainPage"),
  detailPage("/detailPage"),
  webViewPage("/webViewPage"),
  loginPage("/loginPage"),
  notFound("/notFound");

  const NoLoginRequiredRouteEnum(this.path);

  final String path;
}

Map<String, WidgetBuilder> noLoginRequiredRoutesMap = {
  //example
  NoLoginRequiredRouteEnum.sampleList.path: (context) => const SampleList(),
  NoLoginRequiredRouteEnum.completeForm.path: (context) => const CompleteForm(),
  NoLoginRequiredRouteEnum.interlacedAnimation.path: (context) => const InterlacedAnimationDemo(),
  NoLoginRequiredRouteEnum.breathingMethod.path: (context) => const BreathingMethod(),
  NoLoginRequiredRouteEnum.snowMan.path: (context) => const SnowManDemo(),
  NoLoginRequiredRouteEnum.gestureSpring.path: (context) => const GestureSpring(),
  NoLoginRequiredRouteEnum.contactList.path: (context) => const ContactList(),
  NoLoginRequiredRouteEnum.filePreview.path: (context, {arguments}) => FilePreviewPage(arguments: arguments),
  //pages
  NoLoginRequiredRouteEnum.mainPage.path: (context) => const MainPage(),
  NoLoginRequiredRouteEnum.detailPage.path: (context) => const DetailPage(),
  NoLoginRequiredRouteEnum.webViewPage.path: (context) => const WebViewPage(),
  NoLoginRequiredRouteEnum.loginPage.path: (context) => const LoginPage(),
  NoLoginRequiredRouteEnum.notFound.path: (context) => const Page404(),
};
