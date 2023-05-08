import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';
import 'package:jd_mall_flutter/common/widget/image/icon_image.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/redux/state/wel_page_state.dart';

import '../util.dart';

Widget searchHeader(BuildContext context) {
  return Container(
      color: ColorUtil('#FE0F22'),
      padding: EdgeInsets.fromLTRB(0, MediaQueryData.fromWindow(window).padding.top, 0, 0),
      child: Stack(
        alignment:Alignment.center ,
        fit: StackFit.expand, //未定位widget占满Stack整个空间
        children: <Widget>[
          Positioned(
            top: 0,
            left: 16,
            child: iconImage('images/ic_pet.png', 38, 38),
          ),
          Positioned(
            top: 7,
            right: 18,
            child: iconImage('images/ic_scan.png', 28, 28),
          ),
          StoreConnector<AppState, WelPageState>(
            converter: (store) {
              return store.state.welPageState;
            },
            builder: (context, state) {
              return
                Positioned(
                  top: calc2Top(state.pageScrollY),
                  child: Container(
                    height: 34,
                    width: MediaQuery.of(context).size.width - calcWidth(state.pageScrollY),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 40,
                          height: 34,
                          child: UnconstrainedBox(
                            child: iconImage('images/ic_search.png', 20, 20),
                          )
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 34.0,
                            alignment: Alignment.centerLeft,
                            child: Text('跑步鞋', style: TextStyle(
                              color: ColorUtil('#818286'),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          height: 34,
                          child: UnconstrainedBox(
                            child: iconImage('images/ic_camera.png', 20, 20),
                          )
                        )
                      ],
                    ),
                  )
                );
              },
            )
        ],
      )
  );
}

