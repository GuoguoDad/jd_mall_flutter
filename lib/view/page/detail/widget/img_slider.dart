// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/photoGallery/photo_gallery_dialog.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_controller.dart';

Widget imgSlider(BuildContext context, DetailController c) {
  double statusHeight = getStatusHeight(context);
  double imgHeight = getScreenHeight(context) / 2 - statusHeight - getBottomSpace(context);
  double screenWidth = getScreenWidth(context);

  return Container(
    height: imgHeight,
    width: getScreenWidth(context),
    margin: EdgeInsets.only(top: statusHeight),
    child: Obx(() {
      List<String> imgList = c.selectInfo.value.imgList ?? [];

      return FlutterCarousel(
        options: CarouselOptions(
          height: imgHeight,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          autoPlay: true,
          enableInfiniteScroll: true,
          autoPlayInterval: const Duration(seconds: 12),
          slideIndicator: CircularWaveSlideIndicator(
            itemSpacing: 14,
            indicatorRadius: 4,
            indicatorBorderWidth: 0,
            currentIndicatorColor: CommonStyle.themeColor,
            indicatorBackgroundColor: Colors.grey,
          ),
        ),
        items: imgList
            .map((url) => GestureDetector(
                  onTap: () => openPhotoGalleryDialog(context, imgList, imgList.lastIndexWhere((v) => v == url)),
                  child: CachedNetworkImage(
                    height: imgHeight,
                    width: screenWidth,
                    imageUrl: url,
                    placeholder: (context, url) => assetImage(Assets.imagesDefault, screenWidth, imgHeight),
                    errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, screenWidth, imgHeight),
                    fit: BoxFit.fill,
                  ),
                ))
            .toList(),
      );
    }),
  );
}
