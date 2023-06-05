import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_state.dart';
import 'package:jd_mall_flutter/page/welcome/util.dart';
import '../../../common/localization/default_localizations.dart';
import '../../../common/style/common_style.dart';
import '../../../common/widget/persistentHeader/sliver_header_builder.dart';

Widget cartHeader(BuildContext context) {
  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverHeaderDelegate(
      //有最大和最小高度
      maxHeight: 44 + MediaQueryData.fromView(View.of(context)).padding.top,
      minHeight: MediaQueryData.fromView(View.of(context)).padding.top,
      child: Container(
          padding: EdgeInsets.fromLTRB(0, MediaQueryData.fromView(View.of(context)).padding.top, 0, 0),
          color: CommonStyle.colorF1F1F1,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 24,
                child:
                    Text(MallLocalizations.i18n(context).tab_main_cart, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              Positioned(
                  top: 4,
                  left: 100,
                  child: Container(
                    height: 24,
                    width: MediaQuery.of(context).size.width - 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: CommonStyle.colorECEDEC,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            width: 24,
                            height: 24,
                            child: UnconstrainedBox(
                              child: assetImage('images/ic_address.png', 16, 16),
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 24.0,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(right: 2),
                            child: Text('配送至: 江苏省南京市江宁区丰泽路xxx号xxx小区',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: CommonStyle.placeholderColor, fontSize: 14)),
                          ),
                        )
                      ],
                    ),
                  )),
              Positioned(
                top: 2,
                right: 18,
                child: assetImage('images/ic_ellipsis.png', 28, 28),
              )
            ],
          )),
    ),
  );
}
