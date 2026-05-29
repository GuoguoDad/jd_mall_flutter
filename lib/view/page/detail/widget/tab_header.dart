// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_extended_scroll/flutter_extended_scroll.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_provider.dart';
import 'package:jd_mall_flutter/view/page/home/util.dart';

class TabHeader extends StatefulWidget {
  final ExtendedScrollController scrollController;

  const TabHeader(this.scrollController, {super.key});

  @override
  State<TabHeader> createState() => TabHeaderState();
}

class TabHeaderState extends State<TabHeader> {


  @override
  Widget build(BuildContext context) {
    return Consumer<DetailProvider>(
        builder: (context, provider, child) {
          double opacity = calcOpacity(provider.pageScrollY);

          return Container(
            height: 42 + getStatusHeight(),
            color: opacity == 1 ? Colors.white : Colors.transparent,
            width: getScreenWidth(),
            padding: EdgeInsets.only(top: getStatusHeight()),
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
                        tabItem("commodity".tr(), 0, provider),
                        tabItem("evaluate".tr(), 1, provider),
                        tabItem("detail".tr(), 2, provider),
                        tabItem("recommend".tr(), 3, provider),
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
    );
  }

  Widget tabItem(String name, int index, DetailProvider provider) {
    double opacity = calcOpacity(provider.pageScrollY);

    return GestureDetector(
      onTap: () {
        if (provider.index != index) {
          provider.setIsTabClick(true);
          provider.setIndex(index);
          //根据index滚动页面至相应模块位置
          RenderSliverToBoxAdapter? keyRenderObject = cardKeys[index].currentContext?.findAncestorRenderObjectOfType<RenderSliverToBoxAdapter>();
          if (keyRenderObject != null) {
            widget.scrollController.position
                .ensureVisible(keyRenderObject, offsetTop: 42 + getStatusHeight(), duration: const Duration(milliseconds: 300), curve: Curves.linear)
                .then((value) => provider.setIsTabClick(false));
          }
        }
      },
      child: Opacity(
        opacity: opacity,
        child: Container(
          height: 42,
          color: Colors.transparent,
          padding: const EdgeInsets.only(left: 8, right: 8),
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
              Container(
                height: 3,
                width: 30,
                margin: const EdgeInsets.only(top: 5),
                color: provider.index == index ? CommonStyle.themeColor : Colors.transparent,
              )
            ],
          ),
        ),
      ),
    );
  }
}

double calcOpacity(double pageY) {
  double opacity = 0 + pageY * 0.01;
  if (opacity < 0) opacity = 0;
  if (opacity > 1) opacity = 1;

  return opacity;
}
