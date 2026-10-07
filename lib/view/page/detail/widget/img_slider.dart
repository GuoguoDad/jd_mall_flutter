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
  // 用 ValueNotifier 驱动指示器，避免 onPageChanged 时重建整个 PageView
  final ValueNotifier<int> activeIndexNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    activeIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imgHeight,
      width: screenWidth,
      margin: EdgeInsets.only(top: statusHeight),
      child: Selector<DetailProvider, List<String>?>(
        selector: (context, provider) => provider.selectInfo.imgList,
        shouldRebuild: (prev, next) => !identical(prev, next),
        builder: (context, imgList, child) {
          final list = imgList ?? const <String>[];

          if (list.isEmpty) return Container();

          return Stack(
            children: [
              RepaintBoundary(
                child: ExpandablePageView.builder(
                  loop: true,
                  itemCount: list.length,
                  onPageChanged: (index) => activeIndexNotifier.value = index,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => openPhotoGalleryDialog(context, list, list.lastIndexWhere((v) => v == list[index])),
                      child: ExtendImageNetwork(url: list[index],
                        height: imgHeight,
                        width: screenWidth,
                        cache: true,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 8,
                child: RepaintBoundary(
                  child: Container(
                    height: 10,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: ValueListenableBuilder<int>(
                      valueListenable: activeIndexNotifier,
                      builder: (context, activeIndex, child) => AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: list.length,
                        effect: WormEffect(
                            dotWidth: 8.0,
                            dotHeight: 8.0,
                            dotColor: Colors.grey,
                            activeDotColor: CommonStyle.themeColor
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
