// Flutter imports:
import 'package:extended_scroll/extended_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_controller.dart';
import 'package:jd_mall_flutter/view/page/home/util.dart';

// Package imports:

Widget tabHeader(BuildContext context) {
  double statusHeight = getStatusHeight(context);

  Widget tabItem(String name, int index) {
    return Obx(() {
      double opacity = calcOpacity(DetailController.to.pageScrollY.value);
      return GestureDetector(
        onTap: () {
          if (DetailController.to.index.value != index) {
            DetailController.to.setIsTabClick(true);
            DetailController.to.setIndex(index);
            //根据index滚动页面至相应模块位置
            RenderSliverToBoxAdapter? keyRenderObject = cardKeys[index].currentContext?.findAncestorRenderObjectOfType<RenderSliverToBoxAdapter>();
            if (keyRenderObject != null) {
              DetailController.to.scrollController.position
                  .ensureVisible(keyRenderObject, offsetTop: 42 + getStatusHeight(context), duration: const Duration(milliseconds: 300), curve: Curves.linear)
                  .then((value) => DetailController.to.setIsTabClick(false));
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
                  color: DetailController.to.index.value == index ? CommonStyle.themeColor : Colors.transparent,
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  return Obx(() {
    double opacity = calcOpacity(DetailController.to.pageScrollY.value);

    return Container(
      height: 42 + statusHeight,
      color: opacity == 1 ? Colors.white : Colors.transparent,
      width: getScreenWidth(context),
      padding: EdgeInsets.only(top: statusHeight),
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
  });
}

double calcOpacity(double pageY) {
  double opacity = 0 + pageY * 0.01;
  if (opacity < 0) opacity = 0;
  if (opacity > 1) opacity = 1;

  return opacity;
}
