import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/component/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/types/common.dart';

Widget tabList(BuildContext context, {required ValueCallback<String> onTabChange}) {
  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverHeaderDelegate.fixedHeight(
      //固定高度
      height: 54,
      child: Container(
        color: CommonStyle.greyBgColor,
        child: StoreBuilder<AppState>(
          builder: (context, store) {
            var tabs = store.state.homePageState.homePageInfo.tabList ?? [];
            String currentTab = store.state.homePageState.currentTab;
            int totalCount = tabs.length;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: totalCount,
              itemExtent: 84.0,
              itemBuilder: (BuildContext context, int index) {
                bool isSelect = currentTab == tabs[index].code;

                return GestureDetector(
                  onTap: () => onTabChange(tabs[index].code!),
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 84,
                          color: CommonStyle.greyBgColor,
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            tabs[index].name ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelect ? CommonStyle.selectedTabColor : CommonStyle.unSelectedTabColor,
                            ),
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
