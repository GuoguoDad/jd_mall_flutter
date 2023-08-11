// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_state.dart';
import 'package:jd_mall_flutter/view/page/home/util.dart';

Widget searchHeader(BuildContext context, ValueNotifier<double> pageScrollY) {
  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverHeaderDelegate(
      maxHeight: 88 + getStatusHeight(context),
      minHeight: 44 + getStatusHeight(context),
      child: Container(
        color: CommonStyle.themeColor,
        padding: EdgeInsets.only(top: getStatusHeight(context)),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 16,
              child: assetImage('images/ic_pet.png', 36, 36),
            ),
            Positioned(
              top: 5,
              right: 18,
              child: assetImage('images/ic_scan.png', 32, 32),
            ),
            ValueListenableBuilder<double>(
              builder: (BuildContext context, double value, Widget? child) {
                return Positioned(
                  top: calc2Top(value),
                  child: Container(
                    height: 34,
                    width: getScreenWidth(context) - calcWidth(value),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: child,
                  ),
                );
              },
              valueListenable: pageScrollY,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 40,
                    height: 34,
                    child: UnconstrainedBox(
                      child: assetImage('images/ic_search.png', 20, 20),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 34.0,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).homeSearchTip,
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
                      child: assetImage('images/ic_camera.png', 20, 20),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
