import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/carousel/carousel_widget.dart';
import 'package:jd_mall_flutter/component/carousel/helpers/flutter_carousel_options.dart';
import 'package:jd_mall_flutter/component/carousel/indicators/circular_wave_slide_indicator.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/nil.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_page.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_state.dart';

Widget galleryList(BuildContext context) {
  double carouselWidth = getScreenWidth(context) - 24;

  return Container(
    color: CommonStyle.themeColor,
    padding: const EdgeInsets.only(top: 5),
    child: Container(
      padding: const EdgeInsets.only(top: 4),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
      child: StoreConnector<AppState, HomePageState>(
        converter: (store) {
          return store.state.homePageState;
        },
        builder: (context, state) {
          var bannerList = state.homePageInfo.bannerList ?? [];
          int bannerLength = bannerList.length;
          if (bannerLength == 0) {
            return nil;
          }

          return Carousel(
            options: CarouselOptions(
              height: 160,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: true,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 8),
              slideIndicator: CircularWaveSlideIndicator(
                itemSpacing: 12,
                indicatorRadius: 3.6,
                indicatorBorderWidth: 0,
                currentIndicatorColor: CommonStyle.themeColor,
                indicatorBackgroundColor: Colors.grey,
              ),
            ),
            items: bannerList.map(
              (item) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(DetailPage.name),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      child: CachedNetworkImage(
                        imageUrl: item.imgUrl!,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => assetImage("images/default.png", carouselWidth, 168),
                        errorWidget: (context, url, error) => assetImage("images/default.png", carouselWidth, 168),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    ),
  );
}
