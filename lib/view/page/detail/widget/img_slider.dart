import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/widget/carousel/carousel_widget.dart';
import 'package:jd_mall_flutter/common/widget/carousel/helpers/flutter_carousel_options.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';
import 'package:jd_mall_flutter/common/widget/carousel/indicators/circular_wave_slide_indicator.dart';

var slides = [
  "https://m.360buyimg.com/mobilecms/s1080x1080_jfs/t1/212471/24/17530/169099/625d9642Eadb21db3/f5c28554c39fee6d.jpg!q70.jpg",
  "https://m.360buyimg.com/mobilecms/s1080x1080_jfs/t1/223092/16/13147/109176/623043b7Ec33b6057/8dff30acead53213.jpg!q70.jpg",
  "https://m.360buyimg.com/mobilecms/s1080x1080_jfs/t1/217344/6/14891/89067/623043b7E49c2bf31/1c8f4ba0ccf38c9e.jpg!q70.jpg",
  "https://m.360buyimg.com/mobilecms/s1080x1080_jfs/t1/145881/30/24164/150428/623043b7E8fb57fea/44bdb9081eaec2be.jpg!q70.jpg",
  "https://m.360buyimg.com/mobilecms/s1080x1080_jfs/t1/85372/28/21455/69456/623043b7Ef403bd0a/8ca83cf7694ebd07.jpg!q70.jpg",
  "https://m.360buyimg.com/mobilecms/s1080x1080_jfs/t1/87488/39/23761/210846/623043b8E15396993/e71af88949e071ed.jpg!q70.jpg",
  "https://m.360buyimg.com/mobilecms/s1080x1080_jfs/t1/185539/31/21780/117681/6230217cE99cb7265/4de912b7b8ae3bfe.jpg!q70.jpg"
];

double goodsImgHeight = 400;

Widget imgSlider(BuildContext context) {
  double statusHeight = MediaQueryData.fromView(View.of(context)).padding.top;
  double imgHeight = MediaQuery.of(context).size.height / 2 - statusHeight;

  final List<Widget> sliders = slides
      .map((item) => CachedNetworkImage(
            height: imgHeight,
            width: MediaQuery.of(context).size.width,
            imageUrl: item,
            placeholder: (context, url) => assetImage("images/default.png", MediaQuery.of(context).size.width, imgHeight),
            errorWidget: (context, url, error) => assetImage("images/default.png", MediaQuery.of(context).size.width, imgHeight),
            fit: BoxFit.fill,
          ))
      .toList();

  return Container(
      height: imgHeight,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: statusHeight),
      child: Carousel(
        options: CarouselOptions(
          height: imgHeight,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          autoPlay: false,
          enableInfiniteScroll: true,
          autoPlayInterval: const Duration(seconds: 8),
          slideIndicator: CircularWaveSlideIndicator(
              itemSpacing: 14,
              indicatorRadius: 4,
              indicatorBorderWidth: 0,
              currentIndicatorColor: CommonStyle.themeColor,
              indicatorBackgroundColor: Colors.grey),
        ),
        items: sliders,
      ));
}
