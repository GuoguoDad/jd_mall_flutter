// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/view/page/category/category_provider.dart';
import 'package:jd_mall_flutter/view/page/category/widget/header.dart';
import 'package:jd_mall_flutter/view/page/category/widget/left_cate.dart';
import 'package:jd_mall_flutter/view/page/category/widget/right_group.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  final ScrollController scrollController = ScrollController();
  final ScrollController rightScrollController = ScrollController();
  final ScrollController gridViewController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().initPageData();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    rightScrollController.dispose();
    gridViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(context),
        Expanded(
          flex: 1,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              LeftCategoryList(scrollController),
              RightGroupList(rightScrollController, gridViewController),
            ],
          ),
        ),
      ],
    );
  }
}
