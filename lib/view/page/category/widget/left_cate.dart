// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/models/primary_category_list.dart';
import 'package:jd_mall_flutter/view/page/category/category_provider.dart';
import 'package:provider/provider.dart';

double itemHeight = 62.0;

class LeftCategoryList extends StatefulWidget {
  final ScrollController scrollController;
  const LeftCategoryList(this.scrollController, {super.key});

  @override
  State<LeftCategoryList> createState() => LeftCategoryListState();
}

class LeftCategoryListState extends State<LeftCategoryList> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Consumer<CategoryProvider>(
          builder: (context, provider, child) {

            List<CategoryInfo> list = provider.categoryList;
            String prevCode = provider.previous.code ?? "";
            String currCode = provider.current.code ?? "";
            String nextCode = provider.next.code ?? "";

            return ListView.builder(
              controller: widget.scrollController,
              itemCount: list.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                bool isPrev = prevCode == list[index].code;
                bool isSelect = currCode == list[index].code;
                bool isNext = nextCode == list[index].code;

                return GestureDetector(
                  onTap: () {
                    provider.selectLeftCategory(index - 1 >= 0 ? list[index - 1] : CategoryInfo.fromJson({}), list[index],
                        index + 1 <= list.length - 1 ? list[index + 1] : CategoryInfo.fromJson({}));

                    widget.scrollController.animateTo(calc2Top(index, list.length), duration: const Duration(milliseconds: 200), curve: Curves.linear);
                  },
                  child: Container(
                    height: itemHeight,
                    decoration: BoxDecoration(
                      color: isSelect ? Colors.white : CommonStyle.greyBgColor3,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(isPrev ? 20 : 0), topRight: Radius.circular(isNext ? 20 : 0)),
                    ),
                    child: Center(
                      child: Text(list[index].name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                  ),
                );
              },
            );
          }
      ),
    );
  }
}

double calc2Top(int index, int total) {
  //展示高度，即ListView展示高度
  double displayHeight = getScreenHeight() - 50 - getStatusHeight() - 88 - getBottomSpace();
  //item距离ListView顶部距离
  double item2Top = itemHeight * index;
  //item总高度
  double totalItemHeight = itemHeight * total;

  //所需滚动距离
  double distance = item2Top < displayHeight / 2 ? 0.0 : item2Top - displayHeight / 2;
  //如果滚动距离大于 ListView item总高度 减掉 展示高度，则只能滚动item总高度 减掉 展示高度
  if (distance > totalItemHeight - displayHeight) {
    distance = totalItemHeight - displayHeight;
  }
  return distance;
}
