// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/page/home/home_controller.dart';

Widget galleryList() {
  double carouselWidth = getScreenWidth() - 24;
  double carouselHeight = 160;

  return SliverToBoxAdapter(
    child: Container(
      color: CommonStyle.themeColor,
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: Obx(() {
          var bannerList = HomeController.to.homePageInfo.value.bannerList ?? [];
          return FlutterCarousel(
            options: FlutterCarouselOptions(
              height: carouselHeight,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 8),
              disableCenter: true,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              slideIndicator: CircularWaveSlideIndicator(
                slideIndicatorOptions: SlideIndicatorOptions(
                  itemSpacing: 12,
                  indicatorRadius: 3.6,
                  indicatorBorderWidth: 0,
                  currentIndicatorColor: CommonStyle.themeColor,
                  indicatorBackgroundColor: Colors.grey,
                )
              ),
            ),
            items: bannerList.map(
              (item) {
                return GestureDetector(
                  onTap: () => Get.toNamed(RoutesEnum.detailPage.path),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      child: CachedNetworkImage(
                        width: carouselWidth,
                        height: carouselHeight,
                        imageUrl: item.imgUrl!,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => assetImage(Assets.imagesDefault, carouselWidth, carouselHeight),
                        errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, carouselWidth, carouselHeight),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          );
        }),
      ),
    ),
  );
}
