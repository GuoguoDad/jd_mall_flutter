// Package imports:
import 'package:easy_refresh/easy_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void refreshSuccess(RefreshController refreshController) {
  refreshController.refreshCompleted();
  refreshController.resetNoData();
}

void refreshFail(RefreshController refreshController) {
  refreshController.refreshFailed();
  refreshController.resetNoData();
}

void loadMoreSuccess(RefreshController refreshController) {
  refreshController.loadComplete();
}

void loadMoreFail(RefreshController refreshController) {
  refreshController.loadNoData();
}

void easyRefreshSuccess(EasyRefreshController easyRefreshController) {
  easyRefreshController.finishRefresh(IndicatorResult.success);
}

void easyRefreshFail(EasyRefreshController easyRefreshController) {
  easyRefreshController.finishRefresh(IndicatorResult.fail);
}
