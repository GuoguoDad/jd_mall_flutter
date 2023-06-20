import 'package:flutter/cupertino.dart';

double getScreenHeight(BuildContext context) {
  //更新你的 MediaQuery.of 到对应参数的 MediaQuery.*****of 提升应用性能
  return MediaQuery.sizeOf(context).height;
}

double getScreenWidth(BuildContext context) {
  //更新你的 MediaQuery.of 到对应参数的 MediaQuery.*****of 提升应用性能
  return MediaQuery.sizeOf(context).width;
}

double getStatusHeight(BuildContext context) {
  return MediaQueryData.fromView(View.of(context)).padding.top;
}

double getBottomSpace(BuildContext context) {
  return MediaQueryData.fromView(View.of(context)).padding.bottom;
}
