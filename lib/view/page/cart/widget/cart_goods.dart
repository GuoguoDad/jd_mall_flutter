// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_group_list_view/flutter_group_list_view.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/stepper/stepper.dart';
import 'package:jd_mall_flutter/component/stepper/style.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';
import 'package:jd_mall_flutter/models/cart_goods.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/page/cart/cart_controller.dart';
import 'package:jd_mall_flutter/view/vebview/type.dart';

double thumbnailWidth = 80;

Widget cartGoods(BuildContext context) {
  return Obx(
    () {
      List<CartGoods> cartGoods = CartController.to.cartGoods;

      return GroupSliverListView(
        sectionCount: cartGoods.length,
        itemInSectionCount: (int section) => cartGoods[section].goodsList?.length ?? 0,
        headerForSectionBuilder: (int section) {
          return buildHeader(context, CartController.to, section);
        },
        itemInSectionBuilder: (BuildContext context, IndexPath indexPath) {
          return buildItem(context, CartController.to, indexPath);
        },
        separatorBuilder: (IndexPath indexPath) {
          return Container(
            height: 1,
            color: cartGoods[indexPath.section].goodsList?.length != indexPath.index + 1 ? CommonStyle.greyBgColor2 : Colors.white,
          );
        },
        footerForSectionBuilder: (int section) {
          return buildFooter(context, marginBottom: section + 1 != cartGoods.length ? 10 : 0.0);
        },
      );
    },
  );
}

Widget buildHeader(BuildContext context, CartController c, int section) {
  return Container(
    height: 50,
    margin: const EdgeInsets.only(left: 12, right: 12),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      color: Colors.white,
    ),
    child: Obx(() {
      List<CartGoods> cartGoods = c.cartGoods;
      List<String> selectList = c.selectCartGoodsList;
      List<String> sList = selectList.where((element) => element.contains(cartGoods[section].storeCode!)).toList();
      bool isSelectAll = sList.length == cartGoods[section].goodsList?.length;
      String url = cartGoods[section].h5url ?? "";

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 20,
            margin: const EdgeInsets.only(left: 12),
            child: Checkbox(
              value: isSelectAll,
              shape: const CircleBorder(),
              activeColor: Colors.red,
              onChanged: (bool? va) => c.selectStoreGoods(cartGoods[section].storeCode!, !isSelectAll),
            ),
          ),
          Container(margin: const EdgeInsets.only(left: 5), child: assetImage(Assets.imagesIcStore, 24, 24)),
          Container(margin: const EdgeInsets.only(left: 4), child: Text(cartGoods[section].storeName!, style: const TextStyle(fontSize: 16))),
          GestureDetector(
            onTap: () {
              if (url != "") {
                Navigator.of(context).pushNamed(RoutesEnum.webViewPage.path, arguments: WebViewPageArguments(url));
              }
            },
            child: assetImage("images/ic_arrow_right.png", 20, 20),
          )
        ],
      );
    }),
  );
}

Widget buildItem(BuildContext context, CartController c, IndexPath indexPath) {
  return Container(
    margin: const EdgeInsets.only(left: 12, right: 12),
    color: Colors.white,
    child: Obx(() {
      List<CartGoods> cartGoods = c.cartGoods;
      List<String> selectList = c.selectCartGoodsList;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 20,
            margin: const EdgeInsets.only(left: 12),
            child: Checkbox(
              value: selectList.contains(cartGoods[indexPath.section].goodsList![indexPath.index].code!),
              shape: const CircleBorder(),
              activeColor: Colors.red,
              onChanged: (bool? va) => c.selectCartGoods(cartGoods[indexPath.section].goodsList![indexPath.index].code!),
            ),
          ),
          Container(
            width: thumbnailWidth,
            height: thumbnailWidth,
            margin: const EdgeInsets.only(left: 10),
            child: CachedNetworkImage(
              width: thumbnailWidth,
              height: thumbnailWidth,
              imageUrl: cartGoods[indexPath.section].goodsList![indexPath.index].imgUrl!,
              placeholder: (context, url) => assetImage(Assets.imagesDefault, thumbnailWidth, thumbnailWidth),
              errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, thumbnailWidth, thumbnailWidth),
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartGoods[indexPath.section].goodsList![indexPath.index].description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: CommonStyle.color777677),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: CommonStyle.colorF1F1F1,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Text(
                      S.of(context).defaultSpecifications,
                      style: TextStyle(fontSize: 12, color: CommonStyle.color969798),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "￥${cartGoods[indexPath.section].goodsList![indexPath.index].price!}",
                          style: const TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.w500),
                        ),
                        StepperInt(
                          value: cartGoods[indexPath.section].goodsList![indexPath.index].num!,
                          size: 24,
                          style: StepperStyle(
                            foregroundColor: Colors.black87,
                            activeForegroundColor: Colors.black87,
                            activeBackgroundColor: Colors.white,
                            border: Border.all(color: Colors.grey),
                            elevation: 0,
                            buttonAspectRatio: 1.4,
                          ),
                          didChangeCount: (int value) => c.changeCartGoodsNum(cartGoods[indexPath.section].goodsList![indexPath.index].code!, value),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }),
  );
}

Widget buildFooter(BuildContext context, {required double marginBottom}) {
  return Container(
    height: 10,
    margin: EdgeInsets.only(left: 12, right: 12, bottom: marginBottom),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
    ),
  );
}
