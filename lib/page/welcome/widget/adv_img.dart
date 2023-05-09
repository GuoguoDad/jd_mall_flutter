import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';

Widget advBanner(BuildContext context) {
  return SliverToBoxAdapter(
      child: Container(
        color: ColorUtil('#FFFFFF'),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Image.network('https://m15.360buyimg.com/mobilecms/jfs/t1/105817/5/25878/84922/622f2e3eE548c75b1/a564811c5763d4e8.png!q70.jpg',
        width: MediaQuery.of(context).size.width, height: 90, fit: BoxFit.fill)
    )
  );
}