import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/page/category/redux/category_page_state.dart';
import 'category_page_action.dart';

final categoryPageReducer = combineReducers<CategoryPageState>([
  TypedReducer<CategoryPageState, InitCategoryPageAction>((state, action) =>
      CategoryPageState(action.selectedCategoryInfo, action.categoryList, action.secondGroupCategoryInfo, action.selectSecondCategoryInfo)),
  TypedReducer<CategoryPageState, SelectCategoryAction>((state, action) =>
      CategoryPageState(action.selectedCategoryInfo, state.categoryList, state.secondGroupCategoryInfo, state.selectSecondCategoryInfo)),
  TypedReducer<CategoryPageState, SelectSecondCategoryAction>((state, action) =>
      CategoryPageState(state.selectedCategoryInfo, state.categoryList, state.secondGroupCategoryInfo, action.selectSecondCategoryInfo)),
]);
