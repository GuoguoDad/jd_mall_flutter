import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:getwidget/getwidget.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/page/home/redux/home_page_state.dart';

import '../../../common/style/common_style.dart';

Widget galleryList(BuildContext context) {
  double carouselWidth = MediaQuery.of(context).size.width - 24;
  return SliverToBoxAdapter(
      child: Container(
          color: CommonStyle.themeColor,
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Container(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ),
              child: StoreConnector<AppState, HomePageState>(converter: (store) {
                return store.state.homePageState;
              }, builder: (context, state) {
                var bannerList = state.homePageInfo.bannerList ?? [];
                int bannerLength = bannerList?.length ?? 0;
                if (bannerLength == 0) {
                  return Container();
                }
                return GFCarousel(
                  height: 180,
                  autoPlay: true,
                  hasPagination: true,
                  viewportFraction: 1.0,
                  autoPlayInterval: const Duration(seconds: 8),
                  passiveIndicator: Colors.grey,
                  activeIndicator: CommonStyle.themeColor,
                  items: bannerList.map((item) {
                    return Container(
                        margin: const EdgeInsets.fromLTRB(12, 10, 12, 2),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                          child: CachedNetworkImage(
                            imageUrl: item.imgUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => assetImage("images/default.png", carouselWidth, 168),
                            errorWidget: (context, url, error) => assetImage("images/default.png", carouselWidth, 168),
                          ),
                        ));
                  }).toList(),
                );
              }))));
}
