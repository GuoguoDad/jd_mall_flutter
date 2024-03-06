// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:jd_mall_flutter/models/primary_category_list.dart';
import 'package:jd_mall_flutter/models/second_group_category_info.dart';
import 'package:jd_mall_flutter/view/page/category/redux/category_page_action.dart';
import 'package:jd_mall_flutter/view/page/category/redux/category_page_state.dart';
import 'package:jd_mall_flutter/view/page/category/service.dart';

class CategoryPageMiddleware<CategoryPageState> implements MiddlewareClass<CategoryPageState> {
  @override
  call(Store<CategoryPageState> store, action, NextDispatcher next) {
    if (action is InitDataAction) {
      store.dispatch(SetLoadingAction(true));
      CategoryApi.queryCategoryInfo().then(
        (res) {
          List<CategoryInfo> list = res?.categoryList ?? [];
          if (list.isNotEmpty) {
            CategoryApi.querySecondGroupCategoryInfo(list[0].code!).then((result) {
              store.dispatch(SetLoadingAction(false));
              //默认选中第一个分类
              SecondCateList selectSecondCategoryInfo = result.secondCateList.length > 0 ? result.secondCateList[0] : SecondCateList.fromJson({});
              store.dispatch(InitCategoryPageAction(SelectedCategoryInfo(null, list[0], list[1]), list, result, selectSecondCategoryInfo));
            });
          }
        },
      );
    }
    next(action);
  }
}
