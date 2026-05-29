// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/group_grid_view.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/image/extend_image_network.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/models/goods_detail_res.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_provider.dart';
import 'package:jd_mall_flutter/view/page/home/util.dart';

double imgWidth = 60;
double headWidth = 40;
double screenWidth = getScreenWidth();

class AppraiseList extends StatelessWidget {
  AppraiseList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: CommonStyle.colorF5F5F5,
        child: Column(children: [
          Container(
            width: getScreenWidth() - 24,
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
                  key: cardKeys[1],
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "evaluate".tr(),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                appraiseList,
                Container(
                  width: 160,
                  height: 42,
                  margin: EdgeInsets.only(left: getScreenWidth() / 2 - 80),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Text("allEvaluations".tr()),
                )
              ],
            ),
          ),
          Consumer<DetailProvider>(
              builder: (context, provider, child) {
              DetailInfo? detailInfo = provider.goodsDetailRes.detailInfo;

              return itemCard("activityZone".tr(), detailInfo?.hdzq ?? "", 260);
            }
          ),
          Container(
            height: 10,
            width: screenWidth,
            color: CommonStyle.colorF5F5F5,
          ),
          Consumer<DetailProvider>(
              builder: (context, provider, child) {
              DetailInfo? detailInfo = provider.goodsDetailRes.detailInfo;

              return itemCard("storeSelection".tr(), detailInfo?.dnyx ?? "", 500);
            }
          )
        ]),
      ),
    );
  }

  Widget appraiseList = Consumer<DetailProvider>(
      builder: (context, provider, child) {
        List<AppraiseInfo> list = provider.goodsDetailRes.goodsInfo?.appraiseList ?? [];

        return SizedBox(
          width: getScreenWidth() - 20,
          height: list.length * 240,
          child: GroupGridView(
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
                        child: ExtendImageNetwork(url: list[section].headerUrl!,
                          height: headWidth,
                          width: headWidth,
                          cache: true,
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
                child: ExtendImageNetwork(url: list[indexPath.section].imgList![indexPath.index],
                  height: imgWidth,
                  width: imgWidth,
                  cache: true,
                  fit: BoxFit.fill,
                ),
              );
            },
            footerForSection: (section) => Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              child: Text(list[section].color!, style: const TextStyle(fontSize: 16)),
            ),
          ),
        );
      }
  );

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
            placeholder: (context, url) => assetImage(Assets.imagesDefault, screenWidth - 40, 100),
            errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, screenWidth - 40, 100),
            fit: BoxFit.fitWidth,
          )
        ],
      ),
    );
  }

}


