// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/types/common.dart';
import 'package:jd_mall_flutter/component/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/view/page/home/home_controller.dart';

Widget tabList(BuildContext context) {
  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverHeaderDelegate.fixedHeight(
      //固定高度
      height: 54,
      child: Container(
        color: CommonStyle.greyBgColor,
        child: Obx(() {
          var tabs = HomeController.to.homePageInfo.value.tabList ?? [];
          int totalCount = tabs.length;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: totalCount,
            itemExtent: 84.0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => {
                  HomeController.to.setIsTabClick(true),
                  HomeController.to.changeCurrentTab(tabs[index].code!),
                  HomeController.to.pageController
                      .animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.linear)
                      .then((value) => HomeController.to.setIsTabClick(false))
                },
                child: Obx(() {
                  String currentTab = HomeController.to.currentTab.value.isNotEmpty
                      ? HomeController.to.currentTab.value
                      : tabs.isNotEmpty
                          ? tabs[0].code!
                          : "";
                  bool isSelect = currentTab == tabs[index].code;

                  return Flex(
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
                  );
                }),
              );
            },
          );
        }),
      ),
    ),
  );
}
