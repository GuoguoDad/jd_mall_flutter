import 'package:flutter/cupertino.dart';

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getStatusHeight(BuildContext context) {
  return MediaQueryData.fromView(View.of(context)).padding.top;
}

double getBottomSpace(BuildContext context) {
  return MediaQueryData.fromView(View.of(context)).padding.bottom;
}
