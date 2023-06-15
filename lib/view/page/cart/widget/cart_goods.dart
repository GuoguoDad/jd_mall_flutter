import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/widget/stepper/stepper.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';
import 'package:jd_mall_flutter/common/widget/stepper/style.dart';
import 'package:jd_mall_flutter/models/cart_goods.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:flutter_group_list_view/flutter_group_list_view.dart';
import 'package:jd_mall_flutter/view/page/cart/redux/cart_page_action.dart';

Widget cartGoods(BuildContext context) {
  return StoreBuilder<AppState>(builder: (context, store) {
    List<CartGoods> cartGoods = store.state.cartPageState.cartGoods;
    List<String> selectList = store.state.cartPageState.selectCartGoodsList;

    return GroupSliverListView(
      sectionCount: cartGoods.length,
      itemInSectionCount: (int section) {
        return cartGoods[section].goodsList?.length ?? 0;
      },
      headerForSectionBuilder: (int section) {
        List<String> sList = selectList.where((element) => element.contains(cartGoods[section].storeCode!)).toList();
        bool isSelectAll = sList.length == cartGoods[section].goodsList?.length;

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
                width: 28,
                margin: const EdgeInsets.only(left: 12),
                child: Checkbox(
                    value: isSelectAll,
                    shape: const CircleBorder(),
                    activeColor: Colors.red,
                    onChanged: (bool? va) {
                      store.dispatch(SelectStoreGoodsAction(cartGoods[section].storeCode!, !isSelectAll));
                    }),
              ),
              assetImage("images/ic_store.png", 24, 24),
              Container(
                  margin: const EdgeInsets.only(left: 6), child: Text(cartGoods[section].storeName!, style: const TextStyle(fontSize: 16))),
              assetImage("images/ic_arrow_right.png", 20, 20)
            ],
          ),
        );
      },
      itemInSectionBuilder: (BuildContext context, IndexPath indexPath) {
        return Container(
          margin: const EdgeInsets.only(left: 12, right: 12),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 28,
                margin: const EdgeInsets.only(left: 12),
                child: Checkbox(
                    value: selectList.contains(cartGoods[indexPath.section].goodsList![indexPath.index].code!),
                    shape: const CircleBorder(),
                    activeColor: Colors.red,
                    onChanged: (bool? va) {
                      store.dispatch(SelectCartGoodsAction(cartGoods[indexPath.section].goodsList![indexPath.index].code!));
                    }),
              ),
              Container(
                width: 92,
                height: 92,
                margin: const EdgeInsets.only(left: 10),
                child: CachedNetworkImage(
                  imageUrl: cartGoods[indexPath.section].goodsList![indexPath.index].imgUrl!,
                  placeholder: (context, url) => assetImage("images/default.png", 92, 92),
                  errorWidget: (context, url, error) => assetImage("images/default.png", 92, 92),
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
                              "黑色/银色，42，选服务",
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
                                    style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.w500),
                                  ),
                                  StepperInt(
                                    value: cartGoods[indexPath.section].goodsList![indexPath.index].num!,
                                    size: 25,
                                    style: StepperStyle(
                                      foregroundColor: Colors.black87,
                                      activeForegroundColor: Colors.black87,
                                      activeBackgroundColor: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      elevation: 0,
                                      buttonAspectRatio: 1.5,
                                    ),
                                    didChangeCount: (int value) {
                                      store.dispatch(
                                          ChangeCartGoodsNumAction(cartGoods[indexPath.section].goodsList![indexPath.index].code!, value));
                                    },
                                  )
                                ],
                              ))
                        ],
                      )))
            ],
          ),
        );
      },
      separatorBuilder: (IndexPath indexPath) {
        return Container(
          width: MediaQuery.of(context).size.width - 200,
          height: 1,
          color: cartGoods[indexPath.section].goodsList?.length != indexPath.index + 1 ? CommonStyle.greyBgColor2 : Colors.white,
        );
      },
      footerForSectionBuilder: (int section) {
        double marginBottom = section + 1 != cartGoods.length ? 10 : 0.0;
        return Container(
          height: 10,
          margin: EdgeInsets.only(left: 12, right: 12, bottom: marginBottom),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            color: Colors.white,
          ),
        );
      },
    );
  });
}
