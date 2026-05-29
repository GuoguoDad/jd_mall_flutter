// Flutter imports:
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// Package imports:
import 'package:get/get.dart';
import 'package:jd_mall_flutter/component/indicator/common_indicator.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/extend_image_network.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/page/home/home_provider.dart';

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
          child: Consumer<HomeProvider>(
              builder: (context, provider, child) {
                var bannerList = provider.homePageInfo.bannerList ?? [];

                if(bannerList.isEmpty) return Container();

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

  int activeIndex = 0;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (controller.hasClients) {
        int nextPage = (activeIndex + 1) % widget.bannerList.length;
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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ExpandablePageView.builder(
          loop: true,
          controller: controller,
          itemCount: widget.bannerList.length,
          onPageChanged: (index) {
            setState(() { activeIndex = index; });
          },
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => Get.toNamed(RoutesEnum.detailPage.path),
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
        Positioned(
          left: 0,
          right: 0,
          bottom: 8,
          child: Container(
            height: 10,
            width: double.infinity,
            alignment: Alignment.center,
            child: CommonIndicator(
              itemCount: widget.bannerList.length,
              current: activeIndex,
            ),
          ),
        ),
      ],
    );
  }
}
