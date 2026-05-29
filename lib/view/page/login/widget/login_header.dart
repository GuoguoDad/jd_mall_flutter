// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';

Widget header(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: getStatusHeight()),
    height: 54 + getStatusHeight(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
          color: Colors.black,
        ),
        Text(
          "loginHelp".tr(),
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}
