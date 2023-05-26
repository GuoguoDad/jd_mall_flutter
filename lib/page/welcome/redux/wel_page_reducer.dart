import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_action.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_state.dart';

final welPageReducer = combineReducers<WelPageState>([
  //修改loading状态
  TypedReducer<WelPageState, SetLoadingAction>((state, action) => state..isLoading = action.value),
  //记录页面滚动距离
  TypedReducer<WelPageState, ChangePageScrollYAction>((state, action) => state..pageScrollY = action.value),
  //记录九宫格菜单滚动index
  TypedReducer<WelPageState, SetMenuSliderIndex>((state, action) => state..menuSliderIndex = action.value),
  //记录滚动图片index
  TypedReducer<WelPageState, SetCurrentTab>((state, action) => state..currentTab = action.value),
  //设置页面数据
  TypedReducer<WelPageState, SetHomePageInfoAction>((state, action) => state..homePageInfo = action.value),
  //初始化商品数据
  TypedReducer<WelPageState, InitGoodsPageAction>((state, action) => state
    ..pageNum = action.pageNum
    ..goodsPageInfo = action.value),
  //加载更多
  TypedReducer<WelPageState, MoreGoodsPageAction>((state, action) => _onLoadMore(state, action)),
]);

WelPageState _onLoadMore(WelPageState state, MoreGoodsPageAction action) {
  List<GoodsList> goods = state.goodsPageInfo.goodsList ?? [];
  List<GoodsList>? goodsList = [...goods, ...?action.value.goodsList];

  return state
    ..pageNum = action.pageNum
    ..goodsPageInfo =
        GoodsPageInfo(goodsList: goodsList, totalCount: state.goodsPageInfo.totalCount, totalPageCount: state.goodsPageInfo.totalPageCount);
}
