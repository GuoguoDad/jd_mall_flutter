// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

// Project imports:
import 'package:jd_mall_flutter/view/main/main_page.dart';
import 'package:jd_mall_flutter/view/page/cart/cart_controller.dart';
import 'package:jd_mall_flutter/view/page/category/category_controller.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_controller.dart';
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
import 'package:jd_mall_flutter/view/page/home/home_controller.dart';
import 'package:jd_mall_flutter/view/page/login/login_controller.dart';
import 'package:jd_mall_flutter/view/page/login/login_page.dart';
import 'package:jd_mall_flutter/view/page/mine/mine_controller.dart';
import 'package:jd_mall_flutter/view/page/order/generate/generate_order.dart';
import 'package:jd_mall_flutter/view/page/personal/personal_info.dart';
import 'package:jd_mall_flutter/view/system/page404.dart';
import 'package:jd_mall_flutter/view/vebview/webview_page.dart';
import 'middleware/auth_middleware.dart';

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

final unknownRoute = GetPage(name: RoutesEnum.notFound.path, page: () => const Page404());

List<GetPage> appPages = [
  //example
  GetPage(name: RoutesEnum.sampleList.path, page: () => const SampleList()),
  GetPage(name: RoutesEnum.completeForm.path, page: () => const CompleteForm()),
  GetPage(name: RoutesEnum.interlacedAnimation.path, page: () => const InterlacedAnimationDemo()),
  GetPage(name: RoutesEnum.breathingMethod.path, page: () => const BreathingMethod()),
  GetPage(name: RoutesEnum.snowMan.path, page: () => const SnowManDemo()),
  GetPage(name: RoutesEnum.gestureSpring.path, page: () => const GestureSpring()),
  GetPage(name: RoutesEnum.contactList.path, page: () => const ContactList()),
  GetPage(name: RoutesEnum.filePreview.path, page: () => const FilePreviewPage()),
  GetPage(name: RoutesEnum.videoPlayer.path, page: () => const VideoPlayerDemo()),
  //pages
  GetPage(
    name: RoutesEnum.mainPage.path,
    page: () => const MainPage(),
    binding: BindingsBuilder(() {
      Get.lazyPut<HomeController>(() => HomeController());
      Get.lazyPut<CategoryController>(() => CategoryController());
      Get.lazyPut<CartController>(() => CartController());
      Get.lazyPut<MineController>(() => MineController());
      Get.lazyPut<LoginController>(() => LoginController());
    }),
  ),
  GetPage(
    name: RoutesEnum.detailPage.path,
    page: () => const DetailPage(),
    binding: BindingsBuilder(() => Get.lazyPut<DetailController>(() => DetailController())),
  ),
  GetPage(
    name: RoutesEnum.webViewPage.path,
    page: () => const WebViewPage(),
  ),
  GetPage(
    name: RoutesEnum.generateOrder.path,
    page: () => const GenerateOrder(),
    middlewares: [EnsureAuthMiddleware()],
  ),
  GetPage(
    name: RoutesEnum.personalInfo.path,
    page: () => const PersonalInfo(),
    binding: BindingsBuilder(() => Get.lazyPut<LoginController>(() => LoginController())),
    middlewares: [EnsureAuthMiddleware()],
  ),
  GetPage(
    name: RoutesEnum.loginPage.path,
    page: () => const LoginPage(),
    binding: BindingsBuilder(() => Get.lazyPut<LoginController>(() => LoginController())),
  ),
];
