// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/component/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/view/page/home/home_provider.dart';
import 'package:provider/provider.dart';

class TabList extends StatelessWidget {
  const TabList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate.fixedHeight(
        //固定高度
        height: 54,
        child: Container(
          color: CommonStyle.greyBgColor,
          child: Consumer<HomeProvider>(
              builder: (context, provider, child) {
                var tabs = provider.homePageInfo.tabList ?? [];
                String currentTab = provider.currentTab;
                int totalCount = tabs.length;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: totalCount,
                  itemExtent: 84.0,
                  itemBuilder: (BuildContext context, int index) {

                    bool isSelect = currentTab == tabs[index].code;

                    return GestureDetector(
                      onTap: () {
                        provider.setIsTabClick(true);
                        provider.changeCurrentTab(tabs[index].code!);
                        provider.pageController
                            .animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.linear)
                            .then((value) => provider.setIsTabClick(false));
                      },
                      child:  Flex(
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
              }
          ),
        ),
      ),
    );
  }
}

