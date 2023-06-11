import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/view/page/category/redux/category_page_state.dart';
import 'category_page_action.dart';

final categoryPageReducer = combineReducers<CategoryPageState>([
  //页面初始化数据
  TypedReducer<CategoryPageState, InitCategoryPageAction>((state, action) => state
    ..selectedCategoryInfo = action.selectedCategoryInfo
    ..categoryList = action.categoryList
    ..secondGroupCategoryInfo = action.secondGroupCategoryInfo
    ..selectSecondCategoryInfo = action.selectSecondCategoryInfo),
  //选中一级分类
  TypedReducer<CategoryPageState, SelectCategoryAction>((state, action) => state..selectedCategoryInfo = action.selectedCategoryInfo),
  //选中二级分类
  TypedReducer<CategoryPageState, SelectSecondCategoryAction>(
      (state, action) => state..selectSecondCategoryInfo = action.selectSecondCategoryInfo),
]);
