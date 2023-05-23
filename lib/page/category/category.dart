import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/page/category/widget/header.dart';
import 'package:jd_mall_flutter/page/category/widget/left_cate.dart';
import 'package:jd_mall_flutter/page/category/widget/right_group.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  static const String name = "/category";

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    Widget bodyContent = Expanded(
        child: Flex(
      direction: Axis.horizontal,
      children: [leftCate(context), rightGroupList(context)],
    ));

    return Column(
      children: [
        header(context),
        bodyContent,
      ],
    );
  }
}
