import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_state.dart';
import 'package:jd_mall_flutter/page/welcome/util.dart';
import '../../../common/style/common_style.dart';
import '../../../common/widget/persistentHeader/sliver_header_builder.dart';

Widget searchHeader(BuildContext context) {
  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverHeaderDelegate(
      //有最大和最小高度
      maxHeight: 88 + MediaQueryData.fromView(View.of(context)).padding.top,
      minHeight: 44 + MediaQueryData.fromView(View.of(context)).padding.top,
      child: Container(
          color: CommonStyle.themeColor,
          padding: EdgeInsets.fromLTRB(0, MediaQueryData.fromView(View.of(context)).padding.top, 0, 0),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 16,
                child: assetImage('images/ic_pet.png', 38, 38),
              ),
              Positioned(
                top: 7,
                right: 18,
                child: assetImage('images/ic_scan.png', 28, 28),
              ),
              StoreConnector<AppState, WelPageState>(
                converter: (store) {
                  return store.state.welPageState;
                },
                builder: (context, state) {
                  return Positioned(
                      top: calc2Top(state.pageScrollY),
                      child: Container(
                        height: 34,
                        width: MediaQuery.of(context).size.width - calcWidth(state.pageScrollY),
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
                                  child: assetImage('images/ic_search.png', 20, 20),
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 34.0,
                                alignment: Alignment.centerLeft,
                                child: Text('跑步鞋',
                                    style: TextStyle(
                                      color: CommonStyle.placeholderColor,
                                    )),
                              ),
                            ),
                            SizedBox(
                                width: 40,
                                height: 34,
                                child: UnconstrainedBox(
                                  child: assetImage('images/ic_camera.png', 20, 20),
                                ))
                          ],
                        ),
                      ));
                },
              )
            ],
          )),
    ),
  );
}
