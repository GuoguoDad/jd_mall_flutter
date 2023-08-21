// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/component/photo_gallery/photo_gallery.dart';

void openPhotoGalleryDialog(BuildContext context, List<String> items, int index) => showDialog(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: PhotoGallery(
            images: items,
            currentIndex: index,
          ),
        );
      },
    );
