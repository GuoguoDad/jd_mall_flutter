// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_group_list_view/flutter_group_list_view.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/types/common.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/stepper/stepper.dart';
import 'package:jd_mall_flutter/component/stepper/style.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/models/cart_goods.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/cart/redux/cart_page_action.dart';
import 'package:jd_mall_flutter/view/vebview/type.dart';

double thumbnailWidth = 80;

Widget cartGoods(BuildContext context) {
  return StoreBuilder<AppState>(
    builder: (context, store) {
      List<CartGoods> cartGoods = store.state.cartPageState.cartGoods;
      List<String> selectList = store.state.cartPageState.selectCartGoodsList;

      return GroupSliverListView(
        sectionCount: cartGoods.length,
        itemInSectionCount: (int section) => cartGoods[section].goodsList?.length ?? 0,
        headerForSectionBuilder: (int section) {
          List<String> sList = selectList.where((element) => element.contains(cartGoods[section].storeCode!)).toList();
          bool isSelectAll = sList.length == cartGoods[section].goodsList?.length;

          return HeaderSection(
            storeName: cartGoods[section].storeName!,
            url: cartGoods[section].h5url ?? "",
            isSelectAll: isSelectAll,
            cartGoods: cartGoods,
            onCheckChange: (bool? va) {
              store.dispatch(SelectStoreGoodsAction(cartGoods[section].storeCode!, !isSelectAll));
            },
          );
        },
        itemInSectionBuilder: (BuildContext context, IndexPath indexPath) {
          return ItemSection(
            selectList: selectList,
            cartGoods: cartGoods,
            indexPath: indexPath,
            onCheckChange: (bool? va) {
              store.dispatch(SelectCartGoodsAction(cartGoods[indexPath.section].goodsList![indexPath.index].code!));
            },
            onCountChange: (int value) {
              store.dispatch(ChangeCartGoodsNumAction(cartGoods[indexPath.section].goodsList![indexPath.index].code!, value));
            },
          );
        },
        separatorBuilder: (IndexPath indexPath) {
          return Container(
            height: 1,
            color: cartGoods[indexPath.section].goodsList?.length != indexPath.index + 1 ? CommonStyle.greyBgColor2 : Colors.white,
          );
        },
        footerForSectionBuilder: (int section) {
          double marginBottom = section + 1 != cartGoods.length ? 10 : 0.0;
          return FooterSection(
            marginBottom: marginBottom,
          );
        },
      );
    },
  );
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
    required this.storeName,
    required this.url,
    required this.isSelectAll,
    required this.cartGoods,
    required this.onCheckChange,
  });

  final String storeName;
  final String url;
  final bool isSelectAll;
  final List<CartGoods> cartGoods;
  final ValueCallback<bool?> onCheckChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(left: 12, right: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Colors.white,
      ),
      child: Row(
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
              onChanged: (bool? va) => onCheckChange(va),
            ),
          ),
          Container(margin: const EdgeInsets.only(left: 5), child: assetImage("images/ic_store.png", 24, 24)),
          Container(margin: const EdgeInsets.only(left: 4), child: Text(storeName, style: const TextStyle(fontSize: 16))),
          GestureDetector(
            onTap: () {
              if (url != "") {
                Navigator.of(context).pushNamed(RoutesEnum.webViewPage.path, arguments: WebViewPageArguments(url));
              }
            },
            child: assetImage("images/ic_arrow_right.png", 20, 20),
          )
        ],
      ),
    );
  }
}

class ItemSection extends StatelessWidget {
  const ItemSection({
    super.key,
    required this.selectList,
    required this.cartGoods,
    required this.indexPath,
    required this.onCheckChange,
    required this.onCountChange,
  });

  final List<String> selectList;
  final List<CartGoods> cartGoods;
  final IndexPath indexPath;
  final ValueCallback<bool?> onCheckChange;
  final ValueCallback<int> onCountChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12),
      color: Colors.white,
      child: Row(
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
              onChanged: (bool? va) => onCheckChange(va),
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
              placeholder: (context, url) => assetImage("images/default.png", thumbnailWidth, thumbnailWidth),
              errorWidget: (context, url, error) => assetImage("images/default.png", thumbnailWidth, thumbnailWidth),
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
                          didChangeCount: (int value) => onCountChange(value),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({
    super.key,
    required this.marginBottom,
  });

  final double marginBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      margin: EdgeInsets.only(left: 12, right: 12, bottom: marginBottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
    );
  }
}
