// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/types/common.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/linear_button.dart';
import 'package:jd_mall_flutter/view/page/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return pageContainer(
      context,
      child: SizedBox(
        height: 300,
        width: getScreenWidth(context) - 24,
        child: FormBuilder(
          key: LoginController.to.formKey,
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
                child: Obx(
                  () => FormBuilderTextField(
                    name: 'password',
                    decoration: passwordInputDecoration(
                      hintText: '请输入密码',
                      visibility: LoginController.to.showPassword.value,
                      onPress: (va) {
                        LoginController.to.setShowPassword(va);
                      },
                    ),
                    obscureText: !LoginController.to.showPassword.value,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6),
                      FormBuilderValidators.maxLength(16),
                    ]),
                  ),
                ),
              ),
              btnContainer(
                child: LinearButton(
                  btnName: '登录',
                  height: 58,
                  width: getScreenWidth(context) - 24,
                  borderRadius: BorderRadius.circular(50),
                  onTap: () => LoginController.to.login(),
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
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                      color: Colors.black,
                    ),
                    Text(
                      "loginHelp".tr,
                      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
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
