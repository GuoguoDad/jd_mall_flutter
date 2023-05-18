import 'package:jd_mall_flutter/page/category/redux/category_page_action.dart';
import 'package:jd_mall_flutter/page/category/redux/category_page_state.dart';
import 'package:redux/redux.dart';
import '../../../models/primary_category_list.dart';
import '../service.dart';

class CategoryPageMiddleware<CategoryPageState> implements MiddlewareClass<CategoryPageState> {
  @override
  call(Store<CategoryPageState> store, action, NextDispatcher next) {
    if (action is InitDataAction) {
      CategoryApi.queryCategoryInfo().then((res) {
        List<CategoryInfo> list = res.categoryList;
        store.dispatch(InitCategoryPageAction(SelectedCategoryInfo(null, list[0], list[1]), list));
      });
    }
    next(action);
  }
}
