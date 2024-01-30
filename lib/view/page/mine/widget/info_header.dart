// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';
import 'package:jd_mall_flutter/routes.dart';

import 'package:jd_mall_flutter/common/util/util.dart';

Widget infoHeader(BuildContext context, ValueNotifier<double> pageScrollY) {
  Widget title = Positioned(
    top: 0,
    left: (getScreenWidth(context) - 100) / 2,
    child: Container(
      width: 100,
      height: 36,
      alignment: Alignment.center,
      child: ValueListenableBuilder<double>(
        builder: (BuildContext context, double value, Widget? child) {
          HeaderSize headerSize = calcSize(value);
          return Opacity(
            opacity: headerSize.opacity,
            child: Text(
              S.of(context).tabMainMine,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          );
        },
        valueListenable: pageScrollY,
      ),
    ),
  );

  Widget header = ValueListenableBuilder<double>(
    builder: (BuildContext context, double value, Widget? child) {
      HeaderSize headerSize = calcSize(value);
      return Positioned(
        top: headerSize.top,
        left: 0,
        child: Container(
          width: headerSize.size,
          height: headerSize.size,
          margin: const EdgeInsets.only(left: 16),
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(isLogin() ? "images/header.png" : "images/ic_default_header.png"),
            ),
          ),
        ),
      );
    },
    valueListenable: pageScrollY,
  );

  Widget userInfo = ValueListenableBuilder<double>(
    builder: (BuildContext context, double value, Widget? child) {
      HeaderSize headerSize = calcSize(value);
      return Positioned(
        top: headerSize.name2Top,
        left: 100,
        child: SizedBox(
          width: getScreenWidth(context) - 100,
          height: 60,
          child: Opacity(
            opacity: 1 - headerSize.opacity,
            child: child,
          ),
        ),
      );
    },
    valueListenable: pageScrollY,
    child: isLogin()
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                S.of(context).author,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text("${S.of(context).integral}: 200", style: const TextStyle(fontSize: 14)),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      "${S.of(context).creditValue}: 1200",
                      style: const TextStyle(fontSize: 14),
                    ),
                  )
                ],
              )
            ],
          )
        : GestureDetector(
            onTap: () => Navigator.of(context).pushReplacementNamed(RoutesEnum.loginPage.path),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("登录/注册", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                Container(
                  margin: const EdgeInsets.only(top: 1, left: 1),
                  child: assetImage("images/arrow_right_black.png", 24, 24),
                ),
              ],
            ),
          ),
  );

  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverHeaderDelegate(
      //有最大和最小高度
      maxHeight: 130 + getStatusHeight(context),
      minHeight: 48 + getStatusHeight(context),
      child: Container(
        padding: EdgeInsets.only(top: getStatusHeight(context)),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/mine_top_bg.png"),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 4,
              right: 116,
              child: GestureDetector(
                onTap: () => {},
                child: assetImage('images/ic_friend.png', 23, 23),
              ),
            ),
            Positioned(
              top: 4,
              right: 66,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(RoutesEnum.personalInfo.path),
                child: assetImage('images/ic_setting.png', 26, 26),
              ),
            ),
            Positioned(
              top: 4,
              right: 18,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(RoutesEnum.sampleList.path),
                child: assetImage('images/ic_message.png', 26, 26),
              ),
            ),
            title,
            header,
            userInfo
          ],
        ),
      ),
    ),
  );
}

double maxTop = 40;
double minTop = 4;
double nameMaxTop = 48;
double maxSize = 70;
double minSize = 30;
double maxOpacity = 1;
double minOpacity = 0;

HeaderSize calcSize(double y) {
  double toTop = maxTop - y * 0.8;
  double name2Top = nameMaxTop - y * 0.8;
  double realSize = maxSize - y * 0.8;
  double opacity = minOpacity + y * 0.01;
  if (toTop < minTop) toTop = minTop;
  if (toTop > maxTop) toTop = maxTop;
  if (name2Top < minTop) name2Top = minTop;
  if (name2Top > nameMaxTop) name2Top = nameMaxTop;
  if (realSize > maxSize) realSize = maxSize;
  if (realSize < minSize) realSize = minSize;

  if (opacity > maxOpacity) opacity = maxOpacity;
  if (opacity < minOpacity) opacity = minOpacity;

  return HeaderSize(toTop, name2Top, realSize, opacity);
}

class HeaderSize {
  double top;
  double name2Top;
  double size;
  double opacity;

  HeaderSize(this.top, this.name2Top, this.size, this.opacity);
}
