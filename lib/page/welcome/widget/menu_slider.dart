import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_action.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_state.dart';

import '../../../common/constant/index.dart';
import '../../../common/widget/image/asset_image.dart';

const rowNum = 5;
const pageNum = rowNum * 2;

Widget menuSlider(BuildContext context) {
  return SliverToBoxAdapter(
      child: Container(
          color: Colors.white,
          height: 185,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: menuPageList(context)
              ),
              Container(
                height: 15,
                alignment: Alignment.center,
                child: StoreConnector<AppState, WelPageState>(
                  converter: (store) {
                    return store.state.welPageState;
                  },
                  builder: (context, state) {
                    int menuLength = state.homePageInfo.nineMenuList?.length ?? 1;
                    return  ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: (menuLength % pageNum) > 0 ? (menuLength ~/ pageNum) + 1 : (menuLength ~/ pageNum),
                        itemBuilder: (context, index) {
                          return Container(
                              alignment: const Alignment(0, .5),
                              height: 10,
                              width: 10,
                              child:  StoreConnector<AppState, WelPageState>(
                                  converter: (store) {
                                    return store.state.welPageState;
                                  },
                                  builder: (context, state) {
                                    return CircleAvatar(
                                      radius: 3,
                                      backgroundColor: state.menuSliderIndex == index ? ColorUtil.hex2Color('#FE0F22') : Colors.grey,
                                      child: Container(
                                        alignment: const Alignment(0, .5),
                                        width: 10,
                                        height: 10,
                                      ),
                                    );
                                  }
                              )
                          );
                        });
                  },
                )
              )
            ],
          )
      )
  );
}

Widget menuPageList(BuildContext context) {
  return
    StoreBuilder<AppState>(
      builder: (context, store) {
        var menuData = store.state.welPageState.homePageInfo.nineMenuList ?? [];
        int menuLength = menuData?.length ?? -1;

        return PageView.builder(
          itemCount: (menuLength % pageNum ) > 0 ? (menuLength ~/ pageNum) + 1 : (menuLength ~/ pageNum),
          onPageChanged: (index) {
            store.dispatch(SetMenuSliderIndex(index));
          },
          itemBuilder: (BuildContext context, int index) {
            return GridView.builder(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (index < (menuLength ~/ pageNum)) ? pageNum : (menuLength % pageNum),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowNum,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, position){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        imageUrl: menuData[index * pageNum + position].menuIcon.toString()!,
                        placeholder: (context, url) => assetImage("images/default.png", 40, 40),
                        errorWidget: (context, url, error) => assetImage("images/default.png", 40, 40),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          menuData?[index * pageNum + position]?.menuName.toString() ?? "",
                          style: const TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  );
                }
            );
          },
        );
      }
    );
}