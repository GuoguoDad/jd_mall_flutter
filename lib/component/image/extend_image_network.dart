// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:extended_image/extended_image.dart';

// Project imports:
import 'package:jd_mall_flutter/generated/assets.dart';

class ExtendImageNetwork extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final bool? cache;
  final double? width;
  final double? height;

  const ExtendImageNetwork({super.key, required this.url, required this.fit, this.cache, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Image.asset(
        Assets.imagesDefault,
        width: width,
        height: height,
        fit: fit,
      );
    }

    return ExtendedImage.network(
      url,
      width: width,
      height: height,
      cache: cache ?? true,
      fit: fit,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Image.asset(
              Assets.imagesDefault,
              width: width,
              height: height,
              fit: BoxFit.fill,
            );
          case LoadState.completed:
            return state.completedWidget;
          case LoadState.failed:
            //remove memory cached
            state.imageProvider.evict();
            return GestureDetector(
              child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      'images/ic_failed.jpg',
                      width: width,
                      height: height,
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
