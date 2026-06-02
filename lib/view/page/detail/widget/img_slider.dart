// Flutter imports:
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/extend_image_network.dart';
import 'package:jd_mall_flutter/component/photoGallery/photo_gallery_dialog.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

double statusHeight = getStatusHeight();
double imgHeight = getScreenHeight() / 2 - statusHeight - getBottomSpace();
double screenWidth = getScreenWidth();

class ImgSlider extends StatefulWidget {
  const ImgSlider({super.key});

  @override
  State<ImgSlider> createState() => _ImgSliderState();
}

class _ImgSliderState extends State<ImgSlider> {

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imgHeight,
      width: getScreenWidth(),
      margin: EdgeInsets.only(top: statusHeight),
      child: Consumer<DetailProvider>(
        builder: (context, provider, child) {
          List<String> imgList = provider.selectInfo.imgList ?? [];

          if(imgList.isEmpty) return Container();

          return Stack(
            children: [
              ExpandablePageView.builder(
                loop: true,
                itemCount: imgList.length,
                onPageChanged: (index) {
                  setState(() { activeIndex = index; });
                },
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => openPhotoGalleryDialog(context, imgList, imgList.lastIndexWhere((v) => v == imgList[index])),
                    child: ExtendImageNetwork(url: imgList[index],
                      height: imgHeight,
                      width: screenWidth,
                      cache: true,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 8,
                child: Container(
                  height: 10,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: imgList.length,
                    effect: WormEffect(
                        dotWidth: 8.0,
                        dotHeight: 8.0,
                        dotColor: Colors.grey,
                        activeDotColor: CommonStyle.themeColor
                    ),
                  )  ,
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
