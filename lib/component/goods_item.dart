// Flutter imports:
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/extension/color_ext.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/line_two.dart';
import 'package:jd_mall_flutter/component/text_item.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/routes.dart';

// 列表项高频使用的颜色/渐变提升到常量，避免每个 item 每次 build 都做字符串解析
final Color cED4637 = '#ED4637'.toColor();
final Color c737473 = '#737473'.toColor();
final Color cFDF4F0 = '#FDF4F0'.toColor();
final Color cF4F4F5 = '#F4F4F5'.toColor();
final Color cA4A5A4 = '#A4A5A4'.toColor();
final LinearGradient tagGradient = LinearGradient(colors: ['#E44746'.toColor(), '#E3909B'.toColor()]);
final BoxDecoration goodsCardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  // 阴影是瀑布流滚动时的主要 raster 开销，收敛模糊半径
  boxShadow: const [
    BoxShadow(
      color: Color(0xFFE0E0E0),
      offset: Offset(0, 1),
      blurRadius: 4,
    )
  ],
);

Widget goodsItem(BuildContext context, GoodsList item, double width) {
  // 按显示尺寸 * 设备像素比解码，减少内存占用与解码耗时
  final int memCacheSize = (width * MediaQuery.devicePixelRatioOf(context)).round();

  List<Widget> widgets = [
    ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      child: CachedNetworkImage(
        imageUrl: item.imgUrl!,
        width: width,
        height: width,
        memCacheWidth: memCacheSize,
        memCacheHeight: memCacheSize,
        filterQuality: FilterQuality.low,
        placeholder: (context, url) => assetImage(Assets.imagesDefault, width, width),
        errorBuilder: (context, url, error) => assetImage(Assets.imagesDefault, width, width),
        fit: BoxFit.fill,
      ),
    ),
  ];

  if (item.type == "2") {
    widgets.add(
      textItem(
        marginTop: 10,
        paddingLeft: 5,
        paddingRight: 6,
        bgColor: cED4637,
        gradient: tagGradient,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        txt: item.tag.toString(),
        fColor: Colors.white,
        fSize: 14,
      ),
    );
    widgets.add(
      textItem(
        marginTop: 2,
        paddingLeft: 0,
        paddingRight: 6,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        txt: item.des1.toString(),
        fColor: cED4637,
        fSize: 16,
      ),
    );
    widgets.add(
      textItem(
        marginTop: 2,
        paddingLeft: 0,
        paddingRight: 6,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        txt: item.des2.toString(),
        fColor: c737473,
        fSize: 14,
      ),
    );
    widgets.add(
      textItem(
        marginTop: 2,
        paddingLeft: 2,
        paddingRight: 2,
        bgColor: cFDF4F0,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        txt: "点击进入",
        fColor: cED4637,
        fSize: 12,
      ),
    );
  } else {
    widgets.add(
      lineTwo(
        txt: item.description.toString(),
        fColor: c737473,
      ),
    );

    widgets.add(
      Container(
        margin: const EdgeInsets.only(top: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            lineTwo(
              txt: "￥${item.price.toString()}",
              fColor: cED4637,
              fontWeight: FontWeight.bold,
            ),
            textItem(
              marginTop: 2,
              paddingLeft: 2,
              paddingRight: 2,
              bgColor: cF4F4F5,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
              txt: "看相似",
              fColor: cA4A5A4,
              fSize: 12,
            ),
          ],
        ),
      ),
    );
  }

  return GestureDetector(
    onTap: () {
      if (item.type == '1') Navigator.of(context).pushNamed(RoutesEnum.detailPage.path);
      if (item.type == '2') Navigator.of(context).pushNamed(RoutesEnum.webViewPage.path, arguments: {"url": item.h5url});
    },
    child: Container(
      padding: const EdgeInsets.only(bottom: 10),
      margin: const EdgeInsets.only(left: 5, right: 5),
      decoration: goodsCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    ),
  );
}
