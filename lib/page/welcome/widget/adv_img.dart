import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_state.dart';

Widget advBanner(BuildContext context) {
  return SliverToBoxAdapter(
      child: StoreConnector<AppState, WelPageState>(
    converter: (store) {
      return store.state.welPageState;
    },
    builder: (context, state) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: CachedNetworkImage(
          height: 90,
          imageUrl: state.homePageInfo?.adUrl ?? "",
          placeholder: (context, url) => assetImage("images/default.png", MediaQuery.of(context).size.width - 24, 90),
          errorWidget: (context, url, error) => assetImage("images/default.png", MediaQuery.of(context).size.width - 24, 90),
          fit: BoxFit.fill,
        ),
      );
    },
  ));
}
