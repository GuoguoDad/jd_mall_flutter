import 'package:flutter/cupertino.dart';

Widget iconImage(String path, double w, double h) => Image(image: AssetImage(path), width: w, height: h, fit: BoxFit.cover);