// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/view/page/login/widget/login_form.dart';
import 'package:jd_mall_flutter/view/page/login/widget/login_header.dart';
import 'package:jd_mall_flutter/view/page/login/widget/login_other_way.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Container(
        width: getScreenWidth(),
        height: getScreenHeight(),
        color: Colors.white,
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            header(context),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(height: 200, width: getScreenWidth()),
                  Expanded(
                    flex: 1,
                    child: loginForm(context),
                  ),
                  loginOtherWay(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
