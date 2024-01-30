// Dart imports:
import 'dart:ffi';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/types/common.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/linear_button.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/page/login/service.dart';
import 'package:jd_mall_flutter/common/global/Global.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';

import '../../../common/event/index.dart';
import '../../../common/event/msg_event.dart';

class LoginPage extends StatefulWidget {
  final Map? arguments;

  const LoginPage({super.key, this.arguments});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return pageContainer(
      context,
      child: SizedBox(
        height: 300,
        width: getScreenHeight(context) - 24,
        child: FormBuilder(
          key: _formKey,
          initialValue: const {
            'userName': "GuoguoDad",
            'password': "GuoguoDad",
          },
          child: Column(
            children: [
              itemContainer(
                child: FormBuilderTextField(
                  name: 'userName',
                  decoration: circleInputDecoration(hintText: '账号名/邮箱/手机号'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(6),
                    FormBuilderValidators.maxLength(12),
                  ]),
                ),
              ),
              itemContainer(
                child: FormBuilderTextField(
                  name: 'password',
                  decoration: passwordInputDecoration(
                    hintText: '请输入密码',
                    visibility: showPassword,
                    onPress: (va) {
                      setState(() {
                        showPassword = va;
                      });
                    },
                  ),
                  obscureText: !showPassword,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(6),
                    FormBuilderValidators.maxLength(16),
                  ]),
                ),
              ),
              btnContainer(
                child: LinearButton(
                  btnName: '登录',
                  height: 58,
                  width: getScreenWidth(context) - 24,
                  borderRadius: BorderRadius.circular(50),
                  onTap: () async {
                    if (_formKey.currentState!.saveAndValidate()) {
                      var userName = _formKey.currentState?.value['userName'];
                      var password = _formKey.currentState?.value['password'];
                      bool canPop = Navigator.of(Global.navigatorKey.currentContext!).canPop();

                      var res = await LoginApi.login(userName, password);

                      if (res != null) {
                        await Global.preferences!.setString("loginFlag", "LoggedIn");
                        await Global.preferences!.setString("token", res.token);
                        await Global.preferences!.setString("userId", res.userId);
                        await Global.preferences!.setString("userName", res.userName);
                        await Global.preferences!.setString("headerImg", res.headerImg);
                        await Global.preferences!.setString("integral", res.integral.toString());
                        await Global.preferences!.setString("creditValue", res.creditValue.toString());

                        if (widget.arguments != null) {
                          var from = widget.arguments!["from"];
                          var args = widget.arguments!["args"];
                          Navigator.of(Global.navigatorKey.currentContext!).pushReplacementNamed(from, arguments: args);
                        } else if (canPop) {
                          Navigator.of(Global.navigatorKey.currentContext!).pop();
                        } else {
                          Navigator.of(Global.navigatorKey.currentContext!).pushReplacementNamed(RoutesEnum.mainPage.path);
                        }
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget pageContainer(BuildContext context, {required Widget child}) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Container(
        width: getScreenWidth(context),
        height: getScreenHeight(context),
        color: Colors.white,
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: getStatusHeight(context)),
                height: 54 + getStatusHeight(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.close),
                      color: Colors.black,
                    ),
                    Text(
                      S.of(context).loginHelp,
                      style: TextStyle(color: CommonStyle.color777777, fontSize: 20, fontWeight: FontWeight.w500),
                    )
                  ],
                )),
            Expanded(
              flex: 1,
              child: Center(
                child: child,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemContainer({required Widget child}) {
    return SizedBox(
      height: 90,
      width: double.infinity,
      child: child,
    );
  }

  Widget btnContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      child: child,
    );
  }

  InputDecoration passwordInputDecoration({required String hintText, required bool visibility, required ValueCallback<bool> onPress}) {
    return InputDecoration(
      filled: true,
      fillColor: CommonStyle.colorF5F5F5,
      border: const OutlineInputBorder(
        gapPadding: 0,
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      suffixIcon: IconButton(
        icon: Icon(visibility ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          onPress(!visibility);
        },
      ),
      hintText: hintText,
      hintStyle: TextStyle(color: CommonStyle.color828282, letterSpacing: 1, fontSize: 18),
    );
  }

  InputDecoration circleInputDecoration({required String hintText}) {
    return InputDecoration(
      filled: true,
      fillColor: CommonStyle.colorF5F5F5,
      border: const OutlineInputBorder(
        gapPadding: 0,
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      // enabledBorder: const OutlineInputBorder(
      //   gapPadding: 0,
      //   borderSide: BorderSide.none,
      //   borderRadius: BorderRadius.all(Radius.circular(100)),
      // ),
      // errorBorder: const OutlineInputBorder(
      //   gapPadding: 0,
      //   borderSide: BorderSide.none,
      //   borderRadius: BorderRadius.all(Radius.circular(100)),
      // ),
      // focusedErrorBorder: const OutlineInputBorder(
      //   gapPadding: 0,
      //   borderSide: BorderSide.none,
      //   borderRadius: BorderRadius.all(Radius.circular(100)),
      // ),
      // focusedBorder: const OutlineInputBorder(
      //   gapPadding: 0,
      //   borderSide: BorderSide.none,
      //   borderRadius: BorderRadius.all(Radius.circular(100)),
      // ),
      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: hintText,
      hintStyle: TextStyle(color: CommonStyle.color828282, letterSpacing: 1, fontSize: 18),
    );
  }
}
