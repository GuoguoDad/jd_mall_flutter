import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';

import '../../../common/constant/img.dart';
import '../redux/wel_page_state.dart';

Widget advBanner(BuildContext context) {
  return SliverToBoxAdapter(
      child: StoreConnector<AppState, WelPageState>(
        converter: (store) {
          return store.state.welPageState;
        },
        builder: (context, state) {
          return Container(
              color: ColorUtil.hex2Color('#FFFFFF'),
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Image.network(
                  state.homePageInfo?.adUrl ?? defaultImg,
                  width: MediaQuery.of(context).size.width,
                  height: 90,
                  fit: BoxFit.fill
              )
          );
        },
      )
  );
}