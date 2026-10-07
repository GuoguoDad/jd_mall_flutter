// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/page/login/login_provider.dart';
import 'package:jd_mall_flutter/view/page/mine/mine_provider.dart';

class InfoHeader extends StatelessWidget {
  const InfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final mineProvider = context.read<MineProvider>();

    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        //有最大和最小高度
        maxHeight: 130 + getStatusHeight(),
        minHeight: 48 + getStatusHeight(),
        child: Container(
          padding: EdgeInsets.only(top: getStatusHeight()),
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
                  onTap: () => Navigator.of(context).pushNamed(RoutesEnum.personalInfo.path),
                  child: assetImage(Assets.imagesIcSetting, 26, 26),
                ),
              ),
              Positioned(
                top: 4,
                right: 18,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(RoutesEnum.sampleList.path),
                  child: assetImage(Assets.imagesIcMessage, 26, 26),
                ),
              ),
              titleWidget(mineProvider),
              headerWidget(mineProvider),
              userInfoWidget(mineProvider)
            ],
          ),
        ),
      ),
    );
  }

  // 标题：跟随滚动淡入，用文字颜色 alpha 代替 Opacity，避免每帧 saveLayer
  Widget titleWidget(MineProvider mineProvider) {
    return Positioned(
      top: 0,
      left: (screenWidth - 100) / 2,
      child: Container(
        width: 100,
        height: 36,
        alignment: Alignment.center,
        child: ValueListenableBuilder<double>(
          valueListenable: mineProvider.scrollYNotifier,
          builder: (context, scrollY, child) {
            return Text(
              "tabMainMine".tr(),
              style: TextStyle(color: Color.fromRGBO(0, 0, 0, calcSize(scrollY).opacity), fontSize: 20),
            );
          },
        ),
      ),
    );
  }

  Widget headerWidget(MineProvider mineProvider) {
    // 登录态单独订阅，头像 AssetImage 只在这里创建一次，避免每帧重建 DecorationImage
    return Selector<LoginProvider, bool>(
      selector: (context, p) => p.hasLogin,
      shouldRebuild: (prev, next) => prev != next,
      builder: (context, hasLogin, child) {
        final headerImage = AssetImage(hasLogin ? Assets.imagesHeader : Assets.imagesIcDefaultHeader);

        return ValueListenableBuilder<double>(
          valueListenable: mineProvider.scrollYNotifier,
          builder: (context, scrollY, child) {
            HeaderSize headerSize = calcSize(scrollY);

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
                    image: headerImage,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget userInfoWidget(MineProvider mineProvider) {
    return ValueListenableBuilder<double>(
      valueListenable: mineProvider.scrollYNotifier,
      builder: (context, scrollY, child) {
        HeaderSize headerSize = calcSize(scrollY);
        final hasLogin = context.select<LoginProvider, bool>((p) => p.hasLogin);

        // 用文字颜色的 alpha 代替 Opacity，避免每帧 saveLayer 离屏合成
        final alpha = Color.fromRGBO(0, 0, 0, 1 - headerSize.opacity);

        return Positioned(
          top: headerSize.name2Top,
          left: 100,
          child: SizedBox(
            width: screenWidth - 100,
            height: 60,
            child: hasLogin
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "author".tr(),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: alpha),
                      ),
                      Row(
                        children: [
                          Text("${"integral".tr()}: 200", style: TextStyle(fontSize: 14, color: alpha)),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Text(
                              "${"creditValue".tr()}: 1200",
                              style: TextStyle(fontSize: 14, color: alpha),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                : GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(RoutesEnum.loginPage.path),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("登录/注册", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: alpha)),
                        Container(
                          margin: const EdgeInsets.only(top: 1, left: 1),
                          child: Opacity(
                            opacity: 1 - headerSize.opacity,
                            child: assetImage(Assets.imagesArrowRightBlack, 24, 24),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

// 屏幕宽度缓存（顶层变量惰性求值），避免每帧通过 navigatorContext 查询 MediaQuery
final double screenWidth = getScreenWidth();

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
