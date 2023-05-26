import 'package:flutter/material.dart';
import 'image/asset_image.dart';

typedef VoidCallback = void Function();

class BackToTop extends StatelessWidget {
  bool show;

  VoidCallback? onTap;

  BackToTop({super.key, this.onTap, required this.show});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: show,
        child: SizedBox(
            width: 48,
            height: 48,
            child: FloatingActionButton(
              onPressed: onTap,
              backgroundColor: Colors.white,
              child: assetImage('images/ic_back_top.png', 32, 32),
            )));
  }
}
