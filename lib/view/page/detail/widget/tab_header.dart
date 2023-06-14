import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/detail/redux/detail_page_action.dart';

Widget tabHeader(BuildContext context) {
  double statusHeight = getStatusHeight(context);

  Widget tabItem(String name, int index) {
    return StoreBuilder<AppState>(builder: (context, store) {
      int currentIndex = store.state.detailPageState.index;

      return GestureDetector(
          onTap: () => store.dispatch(ChangeTopTabIndexAction(index)),
          child: Container(
            height: 42,
            color: Colors.transparent,
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87, decoration: TextDecoration.none),
                ),
                Container(
                    height: 3,
                    width: 30,
                    margin: const EdgeInsets.only(top: 5),
                    color: currentIndex == index ? CommonStyle.themeColor : Colors.transparent)
              ],
            ),
          ));
    });
  }

  return Container(
    height: 42 + statusHeight,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(top: statusHeight),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16),
                child: assetImage("images/ic_back_black.png", 38, 38),
              )),
        ),
        Expanded(
          flex: 2,
          child: Container(
              alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  tabItem('商品', 0),
                  tabItem('评价', 1),
                  tabItem('详情', 2),
                  tabItem('推荐', 3),
                ],
              )),
        ),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                assetImage("images/ic_share_black.png", 28, 28),
                Container(
                  margin: const EdgeInsets.only(left: 14),
                  child: assetImage("images/ic_ellipsis_black.png", 28, 28),
                )
              ],
            ))
      ],
    ),
  );
}
