// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/view/page/home/home_provider.dart';
import 'package:jd_mall_flutter/view/page/home/util.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        maxHeight: 88 + getStatusHeight(),
        minHeight: 44 + getStatusHeight(),
        child: Container(
          color: CommonStyle.themeColor,
          padding: EdgeInsets.only(top: getStatusHeight()),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 16,
                child: assetImage(Assets.imagesIcPet, 36, 36),
              ),
              Positioned(
                top: 5,
                right: 18,
                child: assetImage(Assets.imagesIcScan, 32, 32),
              ),
              Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  return Positioned(
                    top: calc2Top(provider.pageScrollY),
                    child: Container(
                      height: 34,
                      width: getScreenWidth() - calcWidth(provider.pageScrollY),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 40,
                            height: 34,
                            child: UnconstrainedBox(
                              child: assetImage(Assets.imagesIcSearch, 20, 20),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 34.0,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "homeSearchTip".tr(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: CommonStyle.placeholderColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            height: 34,
                            child: UnconstrainedBox(
                              child: assetImage(Assets.imagesIcCamera, 20, 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
