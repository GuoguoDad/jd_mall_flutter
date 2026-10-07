// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/extend_image_network.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/page/home/home_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

double carouselWidth = getScreenWidth() - 24;
double carouselHeight = 160;

class GalleryList extends StatelessWidget {
  const GalleryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: getScreenWidth(),
        height: 180,
        color: CommonStyle.themeColor,
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: Selector<HomeProvider, List<BannerList>>(
              selector: (context, provider) => provider.homePageInfo.bannerList ?? const <BannerList>[],
              shouldRebuild: (prev, next) => !identical(prev, next),
              builder: (context, bannerList, child) {
                if (bannerList.isEmpty) return Container();

                return CarouselSlider(bannerList);
              }
          ),
        ),
      ),
    );
  }
}

class CarouselSlider extends StatefulWidget {
  final List<BannerList> bannerList;
  const CarouselSlider(this.bannerList, {super.key});

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  late final controller = ExpandablePageController(itemCount: widget.bannerList.length);
  late Timer _timer;

  // 用 ValueNotifier 驱动指示器，避免 onPageChanged 时重建整个 PageView
  final ValueNotifier<int> activeIndexNotifier = ValueNotifier<int>(0);

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (controller.hasClients) {
        int nextPage = (activeIndexNotifier.value + 1) % widget.bannerList.length;
        controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    activeIndexNotifier.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RepaintBoundary(
          child: ExpandablePageView.builder(
            loop: true,
            controller: controller,
            itemCount: widget.bannerList.length,
            onPageChanged: (index) => activeIndexNotifier.value = index,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(RoutesEnum.detailPage.path),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: ExtendImageNetwork(url: widget.bannerList[index].imgUrl!,
                      width: carouselWidth,
                      height: carouselHeight,
                      cache: true,
                      fit: BoxFit.fill,
                    ),
                  ),
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
                  count: widget.bannerList.length,
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
}
