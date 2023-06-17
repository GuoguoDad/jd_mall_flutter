import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';

import '../../../../store/app_state.dart';
import '../redux/home_page_state.dart';

Widget backTop(BuildContext context, {required VoidCallback onTop}) {
  return StoreConnector<AppState, HomePageState>(converter: (store) {
    return store.state.homePageState;
  }, builder: (context, state) {
    return Visibility(
        visible: state.showBackTop,
        child: SizedBox(
            width: 48,
            height: 48,
            child: FloatingActionButton(
              onPressed: onTop,
              backgroundColor: Colors.white,
              child: assetImage('images/ic_back_top.png', 32, 32),
            )));
  });
}
