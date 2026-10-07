// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:loading_indicator/loading_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({
    required this.images,
    this.currentIndex = 0,
    this.max = 2,
    this.min = 1,
    this.showTop = true,
    super.key,
  });

  final List<String> images;
  final int currentIndex;
  final double max;
  final double min;
  final bool showTop;

  @override
  State<StatefulWidget> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  int currentIndex = 0;
  late final PageController pageController;
  late final List<ImageProvider> imageProviders;
  // 页码用独立通知驱动，避免翻页时重建整个 PhotoViewGallery
  late final ValueNotifier<int> pageNotifier;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    pageNotifier = ValueNotifier<int>(widget.currentIndex);
    pageController = PageController(initialPage: widget.currentIndex);

    // 按「屏幕物理像素 × 最大缩放倍率」限制解码尺寸，避免超大原图解码占用几十 MB 内存
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final maxPx = (view.physicalSize.longestSide * widget.max).round();
    imageProviders = widget.images
        .map((url) => ResizeImage(NetworkImage(url), width: maxPx) as ImageProvider)
        .toList(growable: false);
  }

  @override
  void dispose() {
    pageNotifier.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: getScreenWidth(),
              height: getScreenHeight(),
              child: PhotoViewGallery.builder(
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: imageProviders[index],
                    initialScale: PhotoViewComputedScale.contained * 1.0,
                    minScale: PhotoViewComputedScale.contained * widget.min,
                    maxScale: PhotoViewComputedScale.contained * widget.max,
                  );
                },
                scrollPhysics: const ClampingScrollPhysics(),
                loadingBuilder: (context, event) => const Center(
                  child: SizedBox(
                    width: 98,
                    height: 98,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballClipRotateMultiple,
                      colors: [Colors.grey],
                      strokeWidth: 2,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                itemCount: widget.images.length,
                pageController: pageController,
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                onPageChanged: (v) => pageNotifier.value = v,
              ),
            ),
          ),
          Positioned(
            top: getStatusHeight(),
            child: SizedBox(
              height: 50,
              width: getScreenWidth(),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      iconSize: 36,
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: ValueListenableBuilder<int>(
                        valueListenable: pageNotifier,
                        builder: (context, index, child) => Text(
                          widget.showTop ? "${(index + 1) > widget.images.length ? 1 : (index + 1)}/${widget.images.length}" : '',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
