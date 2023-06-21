import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:loading_indicator/loading_indicator.dart';

Widget loadingWidget(BuildContext context, {double? width, double? height}) {
  return Container(
    width: width ?? getScreenWidth(context),
    height: height ?? getScreenHeight(context),
    color: Colors.white,
    child: const Center(
      child: SizedBox(
          width: 60,
          height: 60,
          child: LoadingIndicator(
              indicatorType: Indicator.ballSpinFadeLoader, colors: [Colors.grey], strokeWidth: 0, backgroundColor: Colors.transparent)),
    ),
  );
}
