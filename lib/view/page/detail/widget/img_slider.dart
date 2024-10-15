// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/extend_image_network.dart';
import 'package:jd_mall_flutter/component/photoGallery/photo_gallery_dialog.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_controller.dart';
import 'package:jd_mall_flutter/common/util/util.dart';

Widget imgSlider(BuildContext context) {
  double statusHeight = getStatusHeight();
  double imgHeight = getScreenHeight() / 2 - statusHeight - getBottomSpace();
  double screenWidth = getScreenWidth();

  return Container(
    height: imgHeight,
    width: getScreenWidth(),
    margin: EdgeInsets.only(top: statusHeight),
    child: Obx(() {
      List<String> imgList = DetailController.to.selectInfo.value.imgList ?? [];
      // logger.i(imgList);

      return FlutterCarousel(
        options: FlutterCarouselOptions(
          height: imgHeight,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          autoPlay: true,
          enableInfiniteScroll: true,
          autoPlayInterval: const Duration(seconds: 12),
          slideIndicator: CircularWaveSlideIndicator(
              slideIndicatorOptions: SlideIndicatorOptions(
                itemSpacing: 14,
                indicatorRadius: 4,
                indicatorBorderWidth: 0,
                currentIndicatorColor: CommonStyle.themeColor,
                indicatorBackgroundColor: Colors.grey,
              )
          ),
        ),
        items: imgList
            .map((url) => GestureDetector(
                  onTap: () {
                    int lastIndex = imgList.lastIndexWhere((v) => v == url);
                    logger.i('======lastIndex:${lastIndex}');
                    logger.i(imgList);
                    openPhotoGalleryDialog(context, imgList, lastIndex);
                  },
                  child: ExtendImageNetwork(url: url,
                    height: imgHeight,
                    width: screenWidth,
                    cache: true,
                    fit: BoxFit.fill,
                  ),
                ))
            .toList(),
      );
    }),
  );
}
