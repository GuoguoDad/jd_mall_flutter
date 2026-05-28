// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/extend_image_network.dart';
import 'package:jd_mall_flutter/component/photoGallery/photo_gallery_dialog.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_provider.dart';
import 'package:provider/provider.dart';

double statusHeight = getStatusHeight();
double imgHeight = getScreenHeight() / 2 - statusHeight - getBottomSpace();
double screenWidth = getScreenWidth();

class ImgSlider extends StatelessWidget {
  const ImgSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imgHeight,
      width: getScreenWidth(),
      margin: EdgeInsets.only(top: statusHeight),
      child: Consumer<DetailProvider>(
        builder: (context, provider, child) {
          List<String> imgList = provider.selectInfo.imgList ?? [];

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
              onTap: () => openPhotoGalleryDialog(context, imgList, imgList.lastIndexWhere((v) => v == url)),
              child: ExtendImageNetwork(url: url,
                height: imgHeight,
                width: screenWidth,
                cache: true,
                fit: BoxFit.fill,
              ),
            ))
                .toList(),
          );
        }
      ),
    );
  }
}
