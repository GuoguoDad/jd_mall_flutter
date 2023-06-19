import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/view/page/category/redux/category_page_state.dart';
import 'package:jd_mall_flutter/view/page/category/widget/header.dart';
import 'package:jd_mall_flutter/view/page/category/widget/left_cate.dart';
import 'package:jd_mall_flutter/view/page/category/widget/right_group.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/common/skeleton/loading_skeleton.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  static const String name = "/category";

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    //
    Widget bodyContent = Expanded(
        child: Flex(
      direction: Axis.horizontal,
      children: [leftCate(context), rightGroupList(context)],
    ));

    return StoreConnector<AppState, CategoryPageState>(converter: (store) {
      return store.state.categoryPageState;
    }, builder: (context, state) {
      bool isLoading = state.isLoading;
      if (isLoading) return loadingSkeleton(context);

      return Column(
        children: [
          header(context),
          bodyContent,
        ],
      );
    });
  }
}
