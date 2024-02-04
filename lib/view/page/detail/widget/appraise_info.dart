// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/group_grid_view.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';
import 'package:jd_mall_flutter/models/goods_detail_res.dart';
import 'package:jd_mall_flutter/store/app_state.dart';

double imgWidth = 60;
double headWidth = 40;
double screenWidth = 0;

Widget appraiseInfo(BuildContext context, Key key) {
  screenWidth = getScreenWidth(context);

  return StoreBuilder<AppState>(builder: (context, store) {
    List<AppraiseInfo> list = store.state.detailPageState.goodsDetailRes.goodsInfo?.appraiseList ?? [];
    DetailInfo? detailInfo = store.state.detailPageState.goodsDetailRes.detailInfo;

    Widget appraiseList = GroupGridView(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 5, crossAxisSpacing: 5),
      sectionCount: list.length,
      itemInSectionCount: (int section) => list[section].imgList!.length,
      headerForSection: (section) => Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(
                    height: headWidth,
                    width: headWidth,
                    imageUrl: list[section].headerUrl!,
                    placeholder: (context, url) => assetImage(Assets.imagesDefault, headWidth, headWidth),
                    errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, headWidth, headWidth),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(list[section].userName!, style: const TextStyle(fontSize: 16)),
                )
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10),
              child: Text(list[section].content!, style: const TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
      itemInSectionBuilder: (BuildContext context, IndexPath indexPath) {
        return SizedBox(
          width: imgWidth,
          height: imgWidth,
          child: CachedNetworkImage(
            height: imgWidth,
            width: imgWidth,
            imageUrl: list[indexPath.section].imgList![indexPath.index],
            placeholder: (context, url) => assetImage(Assets.imagesDefault, imgWidth, imgWidth),
            errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, imgWidth, imgWidth),
            fit: BoxFit.fill,
          ),
        );
      },
      footerForSection: (section) => Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        child: Text(list[section].color!, style: const TextStyle(fontSize: 16)),
      ),
    );

    return SliverToBoxAdapter(
      child: Container(
        color: CommonStyle.colorF5F5F5,
        child: Column(children: [
          Container(
            width: getScreenWidth(context) - 24,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  key: key,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    S.of(context).evaluate,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: getScreenWidth(context) - 20,
                  height: list.length * 240,
                  child: appraiseList,
                ),
                Container(
                  width: 160,
                  height: 42,
                  margin: EdgeInsets.only(left: getScreenWidth(context) / 2 - 80),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Text(S.of(context).allEvaluations),
                )
              ],
            ),
          ),
          itemCard(S.of(context).activityZone, detailInfo?.hdzq ?? "", 260),
          Container(
            height: 10,
            width: screenWidth,
            color: CommonStyle.colorF5F5F5,
          ),
          itemCard(S.of(context).storeSelection, detailInfo?.dnyx ?? "", 500)
        ]),
      ),
    );
  });
}

Widget itemCard(String title, String url, double imgHeight) {
  return Container(
    width: screenWidth - 20,
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
            title,
            style: TextStyle(color: CommonStyle.color545454),
          ),
        ),
        CachedNetworkImage(
          width: screenWidth - 40,
          imageUrl: url,
          placeholder: (context, url) => assetImage(Assets.imagesDefault, imgWidth, imgWidth),
          errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, imgWidth, imgWidth),
          fit: BoxFit.fitWidth,
        )
      ],
    ),
  );
}
