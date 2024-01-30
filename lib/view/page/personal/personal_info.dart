// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';

// Project imports:
import 'package:jd_mall_flutter/common/extension/color_ext.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/common_header.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/mixin/image_picker_mixin.dart';

import '../../../common/global/Global.dart';
import '../../../component/linear_button.dart';
import '../../../routes.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> with ImagePickerMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        commonHeader(context, title: "个人信息"),
        Expanded(
          flex: 1,
          child: Container(
            color: "#F3F3F5".toColor(),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserInfoItem(
                  name: "头像",
                  isHeader: true,
                  onItemTap: () => updateAvatar(needCropp: true, callback: (path) => EasyLoading.showInfo(path!)),
                ),
                UserInfoItem(
                  name: "账号名",
                  value: "jd_0662bc4dfdc4e",
                ),
                UserInfoItem(
                  name: "昵称",
                  value: "GuoguoDad",
                )
              ],
            ),
          ),
        ),
        Container(
          width: getScreenWidth(context),
          height: 60 + getBottomSpace(context),
          padding: EdgeInsets.only(bottom: getBottomSpace(context)),
          alignment: Alignment.center,
          child: LinearButton(
            width: getScreenWidth(context) - 24,
            height: 50,
            btnName: '退出登录',
            onTap: () async {
              await Global.preferences?.remove("loginFlag");
              await Global.preferences?.remove("token");
              await Global.preferences?.remove("userId");
              await Global.preferences?.remove("userName");
              await Global.preferences?.remove("headerImg");
              await Global.preferences?.remove("integral");
              await Global.preferences?.remove("creditValue");

              Navigator.of(Global.navigatorKey.currentContext!).pushReplacementNamed(RoutesEnum.loginPage.path);
            },
          ),
        )
      ],
    );
  }
}

class UserInfoItem extends StatelessWidget {
  String name;
  String? value;
  bool? isHeader;
  VoidCallback? onItemTap;

  UserInfoItem({
    required this.name,
    this.value = '',
    this.isHeader = false,
    this.onItemTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemTap!(),
      child: Container(
        height: 58,
        color: Colors.white,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                name,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Row(
              children: [
                isHeader!
                    ? Container(
                        width: 58,
                        height: 58,
                        margin: const EdgeInsets.only(left: 16, right: 10),
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage("images/header.png"),
                          ),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Text(
                          value!,
                          style: TextStyle(color: "#808080".toColor()),
                        ),
                      ),
                assetImage("images/arrow_right_grey100.png", 8, 16)
              ],
            )
          ],
        ),
      ),
    );
  }
}
