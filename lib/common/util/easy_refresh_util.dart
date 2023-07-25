// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:easy_refresh/easy_refresh.dart';

Header classicHeader = const ClassicHeader(
  clamping: true,
  position: IndicatorPosition.locator,
  mainAxisAlignment: MainAxisAlignment.end,
  dragText: '下拉刷新',
  armedText: '松开开始刷新数据',
  readyText: '刷新中...',
  processingText: '刷新中...',
  processedText: '刷新成功',
  messageText: '最后更新时间 %T',
);
