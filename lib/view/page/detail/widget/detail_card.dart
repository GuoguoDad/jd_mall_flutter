import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/view/page/detail/redux/detail_page_state.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';

Widget detailCard(BuildContext context, Key key) {
  double screenWidth = getScreenWidth(context);

  return SliverToBoxAdapter(
      child: StoreConnector<AppState, DetailPageState>(converter: (store) {
    return store.state.detailPageState;
  }, builder: (context, state) {
    List<String>? introductionList = state.goodsDetailRes.detailInfo?.introductionList ?? [];

    return Container(
      key: key,
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: Text(
              "详情",
              style: TextStyle(color: CommonStyle.color545454),
            ),
          ),
          Column(
            children: introductionList
                .map((url) => CachedNetworkImage(
                      width: screenWidth - 40,
                      imageUrl: url,
                      placeholder: (context, url) => assetImage("images/default.png", screenWidth - 40, 100),
                      errorWidget: (context, url, error) => assetImage("images/default.png", screenWidth - 40, 100),
                      fit: BoxFit.fill,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }));
}
