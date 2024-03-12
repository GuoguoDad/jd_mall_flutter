// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/types/common.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';

Widget tabHeader(BuildContext context, ValueNotifier<double> pageScrollY, ValueNotifier<int> currentIndex, {required ValueCallback<int> onChange}) {
  double statusHeight = getStatusHeight(context);

  Widget tabItem(String name, int index) {
    return GestureDetector(
      onTap: () => onChange(index),
      child: ValueListenableBuilder<double>(
        builder: (BuildContext context, double pageY, Widget? child) {
          double opacity = calcOpacity(pageY);

          return Opacity(
            opacity: opacity,
            child: Container(
              height: 42,
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: child,
            ),
          );
        },
        valueListenable: pageScrollY,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                decoration: TextDecoration.none,
              ),
            ),
            ValueListenableBuilder<int>(
              builder: (BuildContext context, int value, Widget? child) {
                return Container(
                  height: 3,
                  width: 30,
                  margin: const EdgeInsets.only(top: 5),
                  color: value == index ? CommonStyle.themeColor : Colors.transparent,
                );
              },
              valueListenable: currentIndex,
            )
          ],
        ),
      ),
    );
  }

  return ValueListenableBuilder<double>(
    builder: (BuildContext context, double pageY, Widget? child) {
      double opacity = calcOpacity(pageY);

      return Container(
        height: 42 + statusHeight,
        color: opacity == 1 ? Colors.white : Colors.transparent,
        width: getScreenWidth(context),
        padding: EdgeInsets.only(top: statusHeight),
        child: child,
      );
    },
    valueListenable: pageScrollY,
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 14),
              child: assetImage("images/ic_back_black.png", 28, 28),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                tabItem(S.of(context).commodity, 0),
                tabItem(S.of(context).evaluate, 1),
                tabItem(S.of(context).detail, 2),
                tabItem(S.of(context).recommend, 3),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              assetImage("images/ic_share_black.png", 20, 20),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 5),
                child: assetImage("images/ic_ellipsis_black.png", 20, 20),
              )
            ],
          ),
        )
      ],
    ),
  );
}

double calcOpacity(double pageY) {
  double opacity = 0 + pageY * 0.01;
  if (opacity < 0) opacity = 0;
  if (opacity > 1) opacity = 1;

  return opacity;
}
