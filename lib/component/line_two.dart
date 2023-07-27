// Flutter imports:
import 'package:flutter/material.dart';

Widget lineTwo({
  required String txt,
  Color? fColor = Colors.white,
  double? fSize = 14,
}) {
  return Text(
    txt,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(color: fColor, fontSize: fSize),
  );
}
