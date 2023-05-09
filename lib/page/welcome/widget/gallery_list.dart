import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';

final List<String> images = [
  "https://m15.360buyimg.com/mobilecms/jfs/t1/218369/27/14203/132191/6226a702E5a0b9236/a11294e884bc7635.jpg!cr_1053x420_4_0!q70.jpg",
  "https://m15.360buyimg.com/mobilecms/jfs/t1/158791/25/27003/106834/620c4bc2Efb15fc57/7c89841a597ce41b.jpg!cr_1053x420_4_0!q70.jpg",
  "https://m15.360buyimg.com/mobilecms/jfs/t1/121592/2/24818/138081/622ccc8fEdf840f95/cd229433d699c70c.jpg!cr_1053x420_4_0!q70.jpg.dpg.webp",
  "https://imgcps.jd.com/ling-cubic/danpin/lab/amZzL3QxLzE2Mjc4Mi8zNi85MTM4LzQ0NjQ1MS82MDQwN2Q4MUVkMDlmMWM5OC9jZWVmOWU0OWVkNzlkNjZkLnBuZw/6Zi_6L-q6L6-5pav6LeR5q2l6Z6L/5qmh6IO25aSW5bqV/60586f6fa1b18f3314204f2d/cr_1125x449_0_166/s/q70.jpg"
];

Widget galleryList(BuildContext context) {
  return SliverToBoxAdapter(
    child: Container(
      color: ColorUtil('#FE0F22'),
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: GFCarousel(
          height: 180,
          autoPlay: false,
          hasPagination: true,
          enlargeMainPage: false,
          viewportFraction: 1.0,
          passiveIndicator: Colors.grey,
          activeIndicator: ColorUtil('#FE0F22'),
          items: images.map((url) {
            return Container(
              margin: const EdgeInsets.fromLTRB(12, 10, 12, 2),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                child: Image.network(
                    url,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width
                ),
              ),
            );
          },
          ).toList(),
        ),
      )
    )
  );
}
