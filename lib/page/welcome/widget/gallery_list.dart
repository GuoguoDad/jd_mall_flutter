import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:getwidget/getwidget.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_state.dart';

Widget galleryList(BuildContext context) {
  return SliverToBoxAdapter(
    child: Container(
      color: ColorUtil.hex2Color('#FE0F22'),
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child:
          StoreConnector<AppState, WelPageState>(
            converter: (store) {
              return store.state.welPageState;
            },
            builder: (context, state) {
              int bannerLength = state.homePageInfo.bannerList?.length ?? 0;
              if(bannerLength == 0) {
                return Container();
              }
              return
                GFCarousel(
                  height: 180,
                  autoPlay: false,
                  hasPagination: true,
                  enlargeMainPage: false,
                  viewportFraction: 1.0,
                  passiveIndicator: Colors.grey,
                  activeIndicator: ColorUtil.hex2Color('#FE0F22'),
                  items: (state.homePageInfo.bannerList ??[]).map((item) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(12, 10, 12, 2),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                        child: Image.network(
                            item.imgUrl ?? "",
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width
                        ),
                      ),
                    );
                  }).toList(),
                );
            }
          )
      )
    )
  );
}
