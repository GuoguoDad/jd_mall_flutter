// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// Project imports:
import 'package:jd_mall_flutter/common/extension/color_ext.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/line_two.dart';
import 'package:jd_mall_flutter/component/text_item.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/vebview/type.dart';

Widget goodsItem(BuildContext context, GoodsList item, double width) {
  //
  List<Widget> widgets = [
    ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      child: CachedNetworkImage(
        width: width,
        height: width,
        imageUrl: item.imgUrl ?? "",
        placeholder: (context, url) => assetImage("images/default.png", width, width),
        errorWidget: (context, url, error) => assetImage("images/default.png", width, width),
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
        bgColor: '#ED4637'.toColor(),
        gradient: LinearGradient(colors: ["#E44746".toColor(), "#E3909B".toColor()]),
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
        fColor: '#ED4637'.toColor(),
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
        fColor: '#737473'.toColor(),
        fSize: 14,
      ),
    );
    widgets.add(
      textItem(
        marginTop: 2,
        paddingLeft: 2,
        paddingRight: 2,
        bgColor: '#FDF4F0'.toColor(),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        txt: "点击进入",
        fColor: '#ED4637'.toColor(),
        fSize: 12,
      ),
    );
  } else {
    widgets.add(
      lineTwo(
        txt: item.description.toString(),
        fColor: "#737473".toColor(),
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
              fColor: '#ED4637'.toColor(),
              fontWeight: FontWeight.bold,
            ),
            textItem(
              marginTop: 2,
              paddingLeft: 2,
              paddingRight: 2,
              bgColor: '#F4F4F5'.toColor(),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
              txt: "看相似",
              fColor: '#A4A5A4'.toColor(),
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
      if (item.type == '2') Navigator.of(context).pushNamed(RoutesEnum.webViewPage.path, arguments: WebViewPageArguments(item.h5url ?? ""));
    },
    child: Container(
      padding: const EdgeInsets.only(bottom: 10),
      margin: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, 0), // 偏移量
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    ),
  );
}
