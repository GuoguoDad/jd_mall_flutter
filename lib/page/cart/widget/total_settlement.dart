import 'package:flutter/material.dart';
import '../../../common/style/common_style.dart';

Widget totalSettlement(BuildContext context) {
  return Container(
    height: 58,
    decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: CommonStyle.colorE6E6E6, width: 0.5), bottom: BorderSide(color: CommonStyle.colorE6E6E6, width: 0.5))),
    child: Row(
      children: [
        Expanded(
            child: Row(
          children: [
            Container(
              width: 28,
              margin: const EdgeInsets.only(left: 12),
              child: Checkbox(value: true, shape: const CircleBorder(), activeColor: Colors.red, onChanged: (bool? va) {}),
            ),
            const Text("全选"),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text("合计:"),
            ),
            const Text("￥3376.00", style: TextStyle(fontWeight: FontWeight.bold))
          ],
        )),
        SizedBox(
          width: 150,
          height: 58,
          child: Center(
              child: Ink(
            width: 130,
            height: 42,
            decoration: const BoxDecoration(
                gradient:
                    LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFDE2F21), Color(0xFFEC592F)]),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              highlightColor: CommonStyle.themeColor,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                alignment: Alignment.center,
                child: const Text(
                  '去结算(4)',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {},
            ),
          )),
        )
      ],
    ),
  );
}
