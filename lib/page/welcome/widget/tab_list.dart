import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_action.dart';

Widget tabList(BuildContext context) {
  return Container(
      color: ColorUtil.hex2Color('#F5F5F4'),
      child: StoreBuilder<AppState>(
          builder: (context, store) {
            var tabs = store.state.welPageState.homePageInfo.tabList;
            String currentTab = store.state.welPageState.currentTab;
            int totalCount = tabs?.length ?? 0;

            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: totalCount,
                itemExtent: 86.0,
                itemBuilder: (BuildContext context, int index) {
                  return
                    GestureDetector(
                      onTap: () => store.dispatch(SetCurrentTab(tabs![index].code!)),
                      child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                width: 86,
                                color: ColorUtil.hex2Color('#F5F5F4'),
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text(
                                  tabs?[index].name ?? "",
                                  style: TextStyle(
                                      color: ColorUtil.hex2Color(currentTab == tabs?[index].code ? '#CC3250' : '#433D33')),
                                ),
                              )
                          ),
                          Container(
                              width: 20,
                              height: 2,
                              decoration: BoxDecoration(
                                color: ColorUtil.hex2Color(currentTab == tabs?[index].code ? '#CC3250' : '#F5F5F4'),
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                              )
                          ),
                          Container(
                              width: 20,
                              height: 12,
                              color: Colors.transparent
                          ),
                        ],
                      )
                    );
                }
            );
          }
      )
    );
}