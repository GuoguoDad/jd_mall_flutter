import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/appraise_info.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/detail_card.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/store_goods.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/tab_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/common/widget/back_to_top.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/detail/redux/detail_page_action.dart';
import 'widget/goods_info.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  static const String name = "/detail";

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    double space = getBottomSpace(context);

    return StoreBuilder<AppState>(onInit: (store) {
      store.dispatch(InitPageAction());
    }, builder: (context, store) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0) {
              double distance = notification.metrics.pixels;
              store.dispatch(ChangePageScrollYAction(distance));
            }
            return false;
          },
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Scaffold(
                      body: Stack(
                        children: [
                          Container(
                            color: CommonStyle.colorF5F5F5,
                            child: SmartRefresher(
                              controller: _refreshController,
                              enablePullUp: true,
                              enablePullDown: false,
                              onLoading: () async {
                                store.dispatch(LoadMoreAction(store.state.detailPageState.pageNum + 1,
                                    () => loadMoreSuccess(_refreshController), () => loadMoreFail(_refreshController)));
                              },
                              child: CustomScrollView(
                                controller: _scrollController,
                                slivers: [goodsInfo(context), appraiseInfo(context), detailCard(context), storeGoods(context)],
                              ),
                            ),
                          ),
                          Positioned(top: 0, left: 0, child: tabHeader(context))
                        ],
                      ),
                      floatingActionButton: BackToTop(_scrollController),
                    )),
                Container(
                  height: 54 + space,
                  padding: EdgeInsets.only(bottom: space),
                  decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey, width: 0.2)),
                )
              ],
            ),
          ));
    });
  }
}
