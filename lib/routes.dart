// Flutter imports:
import 'package:flutter/material.dart';

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
import 'package:jd_mall_flutter/view/page/example/file_preview.dart';
import 'package:jd_mall_flutter/view/page/login/login_page.dart';
import 'package:jd_mall_flutter/view/page/order/generate/generate_order.dart';
import 'package:jd_mall_flutter/view/page/personal/personal_info.dart';
import 'package:jd_mall_flutter/view/system/page404.dart';
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
  filePreview("/filePreview"),
  //pages
  mainPage("/mainPage"),
  detailPage("/detailPage"),
  generateOrder("/generateOrder"),
  webViewPage("/webViewPage"),
  personalInfo("/personalInfo"),
  loginPage("/loginPage"),
  notFound("/notFound");

  const RouteEnum(this.path);

  final String path;
}

Map<String, WidgetBuilder> loginRequiredRoutesMap = {
  RouteEnum.generateOrder.path: (context) => const GenerateOrder(),
  RouteEnum.personalInfo.path: (context) => const PersonalInfo(),
};

Map<String, WidgetBuilder> noLoginRequiredRoutesMap = {
  //example
  RouteEnum.sampleList.path: (context) => const SampleList(),
  RouteEnum.completeForm.path: (context) => const CompleteForm(),
  RouteEnum.interlacedAnimation.path: (context) => const InterlacedAnimationDemo(),
  RouteEnum.breathingMethod.path: (context) => const BreathingMethod(),
  RouteEnum.snowMan.path: (context) => const SnowManDemo(),
  RouteEnum.gestureSpring.path: (context) => const GestureSpring(),
  RouteEnum.contactList.path: (context) => const ContactList(),
  RouteEnum.filePreview.path: (context, {arguments}) => FilePreviewPage(arguments: arguments),
  //pages
  RouteEnum.mainPage.path: (context) => const MainPage(),
  RouteEnum.detailPage.path: (context) => const DetailPage(),
  RouteEnum.webViewPage.path: (context) => const WebViewPage(),
  RouteEnum.loginPage.path: (context) => const LoginPage(),
  RouteEnum.notFound.path: (context) => const Page404(),
};

var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  Function pageBuilder;
  if (noLoginRequiredRoutesMap[name] != null) {
    pageBuilder = noLoginRequiredRoutesMap[name] as Function;
  } else if (loginRequiredRoutesMap[name] != null) {
    // todo check login
    bool isLogin = true;
    pageBuilder = isLogin ? loginRequiredRoutesMap[name] as Function : noLoginRequiredRoutesMap[RouteEnum.loginPage.path] as Function;
  } else {
    pageBuilder = noLoginRequiredRoutesMap[RouteEnum.notFound.path] as Function;
  }
  return MaterialPageRoute(builder: (context) => settings.arguments != null ? pageBuilder(context, arguments: settings.arguments) : pageBuilder(context));
};
