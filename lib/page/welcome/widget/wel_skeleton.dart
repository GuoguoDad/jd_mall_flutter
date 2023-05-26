import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:jd_mall_flutter/common/skeleton/placeholders.dart';

Widget welSkeleton(BuildContext context) {
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SearchPlaceholder(),
            BannerPlaceholder(),
            BoxPlaceholder(
              width: double.infinity,
              height: 90,
              margin: EdgeInsets.only(left: 16, right: 16),
            ),
            LineMenuPlaceholder(lineType: LineMenuType.twoLine),
            SizedBox(height: 16.0),
            ContentPlaceholder(
              lineType: ContentLineType.fiveLines,
            ),
            SizedBox(height: 16.0),
            ContentPlaceholder(
              lineType: ContentLineType.fiveLines,
            ),
            SizedBox(height: 16.0),
            ContentPlaceholder(
              lineType: ContentLineType.fiveLines,
            ),
            SizedBox(height: 16.0),
            ContentPlaceholder(
              lineType: ContentLineType.fiveLines,
            ),
          ],
        ),
      ));
}
