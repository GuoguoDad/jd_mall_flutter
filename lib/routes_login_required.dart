// Flutter imports:
import 'package:flutter/material.dart';

import 'package:jd_mall_flutter/view/page/order/generate/generate_order.dart';
import 'package:jd_mall_flutter/view/page/personal/personal_info.dart';

enum LoginRequiredRouteEnum {
  generateOrder("/generateOrder"),
  personalInfo("/personalInfo");

  const LoginRequiredRouteEnum(this.path);

  final String path;
}

Map<String, WidgetBuilder> loginRequiredRoutesMap = {
  LoginRequiredRouteEnum.generateOrder.path: (context) => const GenerateOrder(),
  LoginRequiredRouteEnum.personalInfo.path: (context) => const PersonalInfo(),
};
