import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingSkeleton(BuildContext context, {double? width, double? height}) {
  return Container(
    width: width ?? getScreenWidth(context),
    height: height ?? getScreenHeight(context),
    color: Colors.white,
    child: Center(
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: const Text(
            "loading",
            style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w500, decoration: TextDecoration.none),
          )),
    ),
  );
}
