// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:extended_image/extended_image.dart';

// Project imports:
import 'package:jd_mall_flutter/generated/assets.dart';

class ExtendImageNetwork extends StatefulWidget {
  final String url;
  final BoxFit fit;
  final bool? cache;
  final double? width;
  final double? height;

  const ExtendImageNetwork({super.key, required this.url, required this.fit, this.cache, this.width, this.height});

  @override
  State<ExtendImageNetwork> createState() => _ExtendImageNetworkState();
}

class _ExtendImageNetworkState extends State<ExtendImageNetwork> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        lowerBound: 0.0,
        upperBound: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      widget.url,
      width: widget.width,
      height: widget.height,
      cache: widget.cache ?? true,
      fit: widget.fit,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            _controller.reset();
            return Image.asset(
              Assets.imagesDefault,
              fit: BoxFit.fill,
            );
          case LoadState.completed:
            if (state.wasSynchronouslyLoaded) {
              return state.completedWidget;
            }
            _controller.forward();
            return FadeTransition(
              opacity: _controller,
              child: state.completedWidget,
            );
          case LoadState.failed:
            _controller.reset();
            //remove memory cached
            state.imageProvider.evict();
            return GestureDetector(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    'images/ic_failed.jpg',
                    fit: BoxFit.fill,
                  ),
                  const Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Text(
                      '加载失败, 重试',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              onTap: () {
                state.reLoadImage();
              },
            );
        }
      }
    );
  }
}
