import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';

Widget header(BuildContext context) {
  return Container(
      color: ColorUtil.hex2Color('#FE0F22'),
      height: 50 + MediaQueryData.fromView(View.of(context)).padding.top,
      padding: EdgeInsets.only(top: MediaQueryData.fromView(View.of(context)).padding.top),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
              top: 0,
              left: 16,
              child: Column(
                children: [
                  assetImage('images/scan.png', 24, 24),
                  const Text(
                    "扫码",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              )),
          Positioned(
              top: 2,
              right: 16,
              child: Column(
                children: [
                  assetImage('images/message.png', 24, 24),
                  const Text(
                    "消息",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              )),
          Positioned(
              top: 1,
              child: Container(
                height: 38,
                width: MediaQuery.of(context).size.width - 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorUtil.hex2Color("#F0F1ED"),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        width: 40,
                        height: 34,
                        child: UnconstrainedBox(
                          child: assetImage('images/ic_search.png', 20, 20),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 36.0,
                        alignment: Alignment.centerLeft,
                        child: Text('这是搜索框',
                            style: TextStyle(
                              color: ColorUtil.hex2Color('#818286'),
                            )),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ));
}
