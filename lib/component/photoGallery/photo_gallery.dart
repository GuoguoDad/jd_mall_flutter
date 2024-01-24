// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
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
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;

    Future.delayed(Duration.zero, () {
      setState(() {
        if (widget.images.length > 1) pageController.jumpToPage(widget.currentIndex);
      });
    });
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
              width: getScreenWidth(context),
              height: getScreenHeight(context),
              child: PhotoViewGallery.builder(
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(
                      widget.images[index],
                    ),
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
                onPageChanged: (v) => setState(() => currentIndex = v),
              ),
            ),
          ),
          Positioned(
            top: getStatusHeight(context),
            child: SizedBox(
              height: 50,
              width: getScreenWidth(context),
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
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        widget.showTop ? "${(currentIndex + 1) > widget.images.length ? 1 : (currentIndex + 1)}/${widget.images.length}" : '',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
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
