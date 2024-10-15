// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/component/photoGallery/photo_gallery.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';

void openPhotoGalleryDialog(BuildContext context, List<String> items, int index) => showDialog(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: SizedBox(
            width: getScreenWidth(),
            height: getScreenHeight(),
            child: Container(
              color: Colors.red,
            ),
          ),
        );
      },
    );
