// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/page/login/login_controller.dart';
import 'package:jd_mall_flutter/view/page/mine/mine_controller.dart';

// Package imports:

Widget infoHeader(BuildContext context) {
  Widget title = Positioned(
    top: 0,
    left: (getScreenWidth(context) - 100) / 2,
    child: Container(
      width: 100,
      height: 36,
      alignment: Alignment.center,
      child: Obx(() {
        HeaderSize headerSize = calcSize(MineController.to.pageScrollY.value);
        return Opacity(
          opacity: headerSize.opacity,
          child: Text(
            "tabMainMine".tr,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        );
      }),
    ),
  );

  Widget header = Obx(() {
    HeaderSize headerSize = calcSize(MineController.to.pageScrollY.value);
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
            image: AssetImage(LoginController.to.hasLogin.value ? Assets.imagesHeader : Assets.imagesIcDefaultHeader),
          ),
        ),
      ),
    );
  });

  Widget userInfo = Obx(() {
    HeaderSize headerSize = calcSize(MineController.to.pageScrollY.value);

    return Positioned(
      top: headerSize.name2Top,
      left: 100,
      child: SizedBox(
        width: getScreenWidth(context) - 100,
        height: 60,
        child: Opacity(
          opacity: 1 - headerSize.opacity,
          child: Obx(() {
            return LoginController.to.hasLogin.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "author".tr,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text("${"integral".tr}: 200", style: const TextStyle(fontSize: 14)),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Text(
                              "${"creditValue".tr}: 1200",
                              style: const TextStyle(fontSize: 14),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                : GestureDetector(
                    onTap: () => Get.toNamed(RoutesEnum.loginPage.path),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("登录/注册", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                        Container(
                          margin: const EdgeInsets.only(top: 1, left: 1),
                          child: assetImage(Assets.imagesArrowRightBlack, 24, 24),
                        ),
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  });

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
            image: AssetImage(Assets.imagesMineTopBg),
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
                child: assetImage(Assets.imagesIcFriend, 23, 23),
              ),
            ),
            Positioned(
              top: 4,
              right: 66,
              child: GestureDetector(
                onTap: () => Get.toNamed(RoutesEnum.personalInfo.path),
                child: assetImage(Assets.imagesIcSetting, 26, 26),
              ),
            ),
            Positioned(
              top: 4,
              right: 18,
              child: GestureDetector(
                onTap: () => Get.toNamed(RoutesEnum.sampleList.path),
                child: assetImage(Assets.imagesIcMessage, 26, 26),
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
