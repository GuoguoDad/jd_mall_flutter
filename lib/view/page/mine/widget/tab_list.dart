// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/view/page/mine/mine_provider.dart';

class TabList extends StatefulWidget {
  final PageController pageController;
  const TabList(this.pageController, {super.key});

  @override
  State<TabList> createState() => TabListState();
}

class TabListState extends State<TabList> {
  ScrollController controller = ScrollController();
  double screenWidth = getScreenWidth();

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate.fixedHeight(
        //固定高度
        height: 54,
        child: Container(
          color: CommonStyle.greyBgColor,
          child:Consumer<MineProvider>(
            builder: (context, provider, child) {

              var tabs = provider.menuTabInfo.tabList ?? [];
              String currentTab = provider.currentTab;
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
                      provider.setIsTabClick(true);
                      provider.changeCurrentTab(tabs[index].code!);
                      widget.pageController
                          .animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.linear)
                          .then((value) => provider.setIsTabClick(false));
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
            }
          ),
        ),
      ),
    );
  }
}
