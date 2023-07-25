// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/color_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_page.dart';
import 'package:jd_mall_flutter/view/vebview/type.dart';
import 'package:jd_mall_flutter/view/vebview/webview_page.dart';

Widget goodsItem(BuildContext context, GoodsList item, double width) {
  return GestureDetector(
    onTap: () {
      if (item.type == '1') Navigator.of(context).pushNamed(DetailPage.name);
      if (item.type == '2') Navigator.of(context).pushNamed(WebViewPage.name, arguments: WebViewPageArguments(item.h5url!));
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
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
            child: CachedNetworkImage(
              imageUrl: item.imgUrl!,
              placeholder: (context, url) => assetImage("images/default.png", width, width),
              errorWidget: (context, url, error) => assetImage("images/default.png", width, width),
              fit: BoxFit.fill,
            ),
          ),
          item.type == "2"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(left: 5, right: 6),
                      decoration: BoxDecoration(
                        color: ColorUtil.hex2Color('#ED4637'),
                        gradient: LinearGradient(colors: [ColorUtil.hex2Color("#E44746"), ColorUtil.hex2Color("#E3909B")]),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(item.tag.toString(), style: const TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.only(left: 0, right: 6),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Text(item.des1.toString(), style: TextStyle(color: ColorUtil.hex2Color('#ED4637'), fontSize: 16)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.only(left: 0, right: 6),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Text(item.des2.toString(), style: TextStyle(color: ColorUtil.hex2Color('#737473'), fontSize: 14)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      decoration: BoxDecoration(
                        color: ColorUtil.hex2Color('#FDF4F0'),
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Text("点击进入", style: TextStyle(color: ColorUtil.hex2Color('#ED4637'), fontSize: 12)),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      item.description.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: ColorUtil.hex2Color('#737473'), fontSize: 14),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "￥${item.price.toString()}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: ColorUtil.hex2Color('#ED4637'), fontSize: 14),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            padding: const EdgeInsets.only(left: 2, right: 2),
                            decoration: BoxDecoration(
                              color: ColorUtil.hex2Color('#F4F4F5'),
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                            ),
                            child: Text("看相似", style: TextStyle(color: ColorUtil.hex2Color('#A4A5A4'), fontSize: 12)),
                          )
                        ],
                      ),
                    )
                  ],
                )
        ],
      ),
    ),
  );
}
