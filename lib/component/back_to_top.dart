// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/generated/assets.dart';

class BackToTop extends StatefulWidget {
  final ScrollController controller;

  const BackToTop(this.controller, {super.key});

  @override
  State<StatefulWidget> createState() => _BackToTopState();
}

class _BackToTopState extends State<BackToTop> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(onScroll);
  }

  void onScroll() {
    setState(() {
      show = widget.controller.offset > getScreenHeight(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: SizedBox(
        width: 48,
        height: 48,
        child: FloatingActionButton(
          onPressed: () => widget.controller.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.linear),
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          child: assetImage(Assets.imagesIcBackTop, 28, 28),
        ),
      ),
    );
  }
}
