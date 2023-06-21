import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/view/page/category/widget/header.dart';
import 'package:jd_mall_flutter/view/page/category/widget/left_cate.dart';
import 'package:jd_mall_flutter/view/page/category/widget/right_group.dart';
import 'package:jd_mall_flutter/view/page/category/redux/category_page_action.dart';
import 'package:jd_mall_flutter/store/app_state.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  static const String name = "/category";

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(onInit: (store) {
      store.dispatch(InitDataAction());
    }, builder: (context, store) {
      bool isLoading = store.state.categoryPageState.isLoading;
      if (isLoading) return loadingWidget(context);

      return Column(
        children: [
          header(context),
          Expanded(
              child: Flex(
            direction: Axis.horizontal,
            children: [leftCate(context), rightGroupList(context)],
          )),
        ],
      );
    });
  }
}
