// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

// Project imports:
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/view/page/category/category_controller.dart';
import 'package:jd_mall_flutter/view/page/category/widget/header.dart';
import 'package:jd_mall_flutter/view/page/category/widget/left_cate.dart';
import 'package:jd_mall_flutter/view/page/category/widget/right_group.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  final CategoryController c = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(context),
        Expanded(
          flex: 1,
          child: Obx(() {
            bool isLoading = c.isLoading.value;

            return isLoading
                ? loadingWidget(context)
                : Flex(
                    direction: Axis.horizontal,
                    children: [
                      leftCate(context),
                      rightGroupList(context),
                    ],
                  );
          }),
        ),
      ],
    );
  }
}
