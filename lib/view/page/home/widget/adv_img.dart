// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/component/image/extend_image_network.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/page/home/home_provider.dart';

class AdvBanner extends StatelessWidget {
  const AdvBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          RoutesEnum.webViewPage.path,
          arguments: {"url": "https://pro.m.jd.com/mall/active/2WrXYwmYpiy7EpWjDETSVyhXfLCb/index.html"},
        ),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(0),
          child: Consumer<HomeProvider>(
              builder: (context, provider, child) {
                return ExtendImageNetwork(
                  url: provider.homePageInfo.adUrl ?? "",
                  height: 90,
                  cache: true,
                  fit: BoxFit.fill,
                );
              }
          ),
        ),
      ),
    );
  }
}
