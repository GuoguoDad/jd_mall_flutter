import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../common/util/color_util.dart';
import '../../../common/widget/image/asset_image.dart';
import '../../../models/goods_page_info.dart';
import '../../../redux/app_state.dart';
import '../redux/wel_page_state.dart';

double width = 0;
Widget goodsList(BuildContext context) {
  width = (MediaQuery.of(context).size.width - 20) / 2;

  return StoreConnector<AppState, WelPageState>(
      converter: (store) {
        return store.state.welPageState;
      },
      builder: (context, state) {
        var goodsList = state.goodsPageInfo.goodsList ?? [];
        return SliverMasonryGrid.count(
          childCount: goodsList.length,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 0,
          itemBuilder: (context, index) => goodsItem(goodsList[index]),
        );
      },
    );
}

Widget goodsItem(GoodsList item){
  return Container(
    padding: const EdgeInsets.only(bottom: 10),
    margin: const EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: item.imgUrl!,
          placeholder: (context, url) => assetImage("images/default.png", width, width),
          errorWidget: (context, url, error) => assetImage("images/default.png", width, width),
          fit: BoxFit.fill,
        ),
        item.type == "2" ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 5, right: 6),
                decoration: BoxDecoration(
                  color: ColorUtil.hex2Color('#ED4637'),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
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
          :
          Column(
            children: [
              Text(
                  item.description.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: ColorUtil.hex2Color('#737473'), fontSize: 14)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "￥${item.price.toString()}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: ColorUtil.hex2Color('#ED4637'), fontSize: 14)
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
              )
            ],
          )
      ],
    ),
  );
}