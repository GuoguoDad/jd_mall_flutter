// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/category/redux/category_page_action.dart';
import 'package:jd_mall_flutter/view/page/category/widget/header.dart';
import 'package:jd_mall_flutter/view/page/category/widget/left_cate.dart';
import 'package:jd_mall_flutter/view/page/category/widget/right_group.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  static const String name = "/category";

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late ScrollController _scrollController;
  late ScrollController _rightScrollController;
  late ScrollController _gridViewController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _rightScrollController = ScrollController();
    _gridViewController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _rightScrollController.dispose();
    _gridViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: (store) {
        store.dispatch(InitDataAction());
      },
      builder: (context, store) {
        bool isLoading = store.state.categoryPageState.isLoading;

        return Column(
          children: [
            header(context),
            Expanded(
              child: isLoading
                  ? loadingWidget(context)
                  : Flex(
                      direction: Axis.horizontal,
                      children: [
                        leftCate(context, _scrollController),
                        rightGroupList(context, _rightScrollController, _gridViewController),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }
}
