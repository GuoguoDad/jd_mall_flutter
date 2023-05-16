import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';

const tabs = [
  {
    "name": "精选",
    "code": "1"
  },
  {
    "name": "新品",
    "code": "2"
  },
  {
    "name": "直播",
    "code": "3"
  },
  {
    "name": "实惠",
    "code": "4"
  },
  {
    "name": "进口",
    "code": "5"
  }
];
Widget tabList(BuildContext context) {
  return Container(
      color: ColorUtil.hex2Color('#F5F5F4'),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemExtent: 90.0,
        itemBuilder: (BuildContext context, int index) {
          return Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(tabs[index]["name"]!, style: TextStyle(color: ColorUtil.hex2Color('#CC3250')),),
                )
              ),
              Container(
                width: 20,
                height: 2,
                decoration: BoxDecoration(
                  color: ColorUtil.hex2Color('#CC3250'),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                )
              ),
              Container(
                width: 20,
                height: 12,
                color: Colors.transparent
              ),
            ],
          );
        }
      ),
    );
}