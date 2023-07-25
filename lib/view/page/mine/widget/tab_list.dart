// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/types/common.dart';

Widget tabList(BuildContext context, {required ValueCallback<String> onTabChange}) {
  ScrollController controller = ScrollController();
  double screenWidth = getScreenWidth(context);

  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverHeaderDelegate.fixedHeight(
      //固定高度
      height: 58,
      child: Container(
        color: CommonStyle.greyBgColor,
        child: StoreBuilder<AppState>(
          builder: (context, store) {
            var tabs = store.state.minePageState.menuTabInfo.tabList ?? [];
            String currentTab = store.state.minePageState.currentTab;
            int totalCount = tabs.length;

            final keys = <GlobalKey>[];
            for (var element in tabs) {
              keys.add(GlobalKey(debugLabel: 'mine_tab_${element.code}'));
            }

            void tabScrollToMiddle(int index) {
              double toLeft = 0;
              double total = 0;
              double curWidth = 0;
              if (index != 0) {
                int newIndex = index - 1;
                for (int i = 0; i < keys.length; i++) {
                  RenderBox? box = keys[i].currentContext?.findAncestorRenderObjectOfType<RenderBox>();
                  if (box != null) {
                    //水平范围
                    double w = box.size.width;
                    if (index == i) curWidth = w;
                    total += w;
                    if (i <= newIndex) {
                      toLeft += w;
                    }
                  }
                }
                toLeft = toLeft - screenWidth / 2 + curWidth / 2;
                if (toLeft < 0) toLeft = 0;
                if (toLeft > total - screenWidth) toLeft = total - screenWidth;
              }
              controller.animateTo(toLeft, duration: const Duration(milliseconds: 300), curve: Curves.linear);
            }

            return ListView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemCount: totalCount,
              itemExtent: 90,
              itemBuilder: (BuildContext context, int index) {
                bool isSelect = currentTab == tabs[index].code;

                return GestureDetector(
                  key: keys[index],
                  onTap: () {
                    onTabChange(tabs[index].code!);
                    tabScrollToMiddle(index);
                  },
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 90,
                          color: CommonStyle.greyBgColor,
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            tabs[index].name ?? "",
                            style: TextStyle(
                                fontSize: 14,
                                color: isSelect ? CommonStyle.selectedTabColor : CommonStyle.unSelectedTabColor,
                                fontWeight: isSelect ? FontWeight.bold : FontWeight.w500,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 2,
                        decoration: BoxDecoration(
                          color: isSelect ? CommonStyle.selectedTabColor : CommonStyle.greyBgColor,
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      Container(width: 20, height: 12, color: Colors.transparent),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    ),
  );
}
