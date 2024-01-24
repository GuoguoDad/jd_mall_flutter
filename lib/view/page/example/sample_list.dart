// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:file_preview/file_preview.dart';

// Project imports:
import 'package:jd_mall_flutter/component/common_header.dart';
import 'package:jd_mall_flutter/routes_login_no_require.dart';
import 'package:jd_mall_flutter/view/page/example/widget/list_item.dart';

class SampleList extends StatefulWidget {
  const SampleList({Key? key}) : super(key: key);

  @override
  State<SampleList> createState() => _SampleListState();
}

class _SampleListState extends State<SampleList> {
  bool isInit = false;
  String? version;

  @override
  void initState() {
    _initTBS();
    super.initState();
  }

  void _initTBS() async {
    isInit = await FilePreview.initTBS(license: "your license");
    version = await FilePreview.tbsVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          commonHeader(context, title: "案例"),
          Expanded(
            flex: 1,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListItem(
                  title: '【动画】之交错动画',
                  subtitle: '【动画】之交错动画',
                  icon: Icons.person,
                  onTap: () => Navigator.of(context).pushNamed(NoLoginRequiredRouteEnum.interlacedAnimation.path),
                ),
                ListItem(
                  title: '【动画】之CustomPointer',
                  subtitle: '【动画】之CustomPointer',
                  icon: Icons.line_style,
                  onTap: () => Navigator.of(context).pushNamed(NoLoginRequiredRouteEnum.snowMan.path),
                ),
                ListItem(
                  title: '【动画】之478呼吸法',
                  subtitle: '【动画】之478呼吸法',
                  icon: Icons.tab_rounded,
                  onTap: () => Navigator.of(context).pushNamed(NoLoginRequiredRouteEnum.breathingMethod.path),
                ),
                ListItem(
                  title: 'form表单验证',
                  subtitle: 'form表单验证',
                  icon: Icons.tab_rounded,
                  onTap: () => Navigator.of(context).pushNamed(NoLoginRequiredRouteEnum.completeForm.path),
                ),
                ListItem(
                  title: '【手势】之弹簧',
                  subtitle: '【手势】之弹簧',
                  icon: Icons.tab_rounded,
                  onTap: () => Navigator.of(context).pushNamed(NoLoginRequiredRouteEnum.gestureSpring.path),
                ),
                ListItem(
                  title: '通讯录',
                  subtitle: '通讯录',
                  icon: Icons.tab_rounded,
                  onTap: () => Navigator.of(context).pushNamed(NoLoginRequiredRouteEnum.contactList.path),
                ),
                ListItem(
                  title: '文件预览',
                  subtitle: '文件预览',
                  icon: Icons.tab_rounded,
                  onTap: () => Navigator.of(context)
                      .pushNamed(NoLoginRequiredRouteEnum.filePreview.path, arguments: {"path": "https://gstory.vercel.app/ceshi/ceshi.pdf"}),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
