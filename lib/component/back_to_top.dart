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

  // 屏幕高度缓存：避免每次滚动回调都通过全局 navigatorKey 查询 MediaQuery
  late final double screenHeight = getScreenHeight();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onScroll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onScroll);
    super.dispose();
  }

  void onScroll() {
    // 只有显隐状态真正翻转时才 setState，避免滚动期间每帧重建
    final next = widget.controller.offset > screenHeight;
    if (next == show) return;
    if (!mounted) return;
    setState(() => show = next);
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
