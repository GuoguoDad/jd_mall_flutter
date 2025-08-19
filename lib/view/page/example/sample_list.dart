// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/component/common_header.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/page/example/widget/list_item.dart';

// Package imports:
// import 'package:file_preview/file_preview.dart';


class SampleList extends StatefulWidget {
  const SampleList({super.key});

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
    // isInit = await FilePreview.initTBS(license: "your license");
    // version = await FilePreview.tbsVersion();
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
                  onTap: () => Get.toNamed(RoutesEnum.interlacedAnimation.path),
                ),
                ListItem(
                  title: '【动画】之CustomPointer',
                  subtitle: '【动画】之CustomPointer',
                  icon: Icons.line_style,
                  onTap: () => Get.toNamed(RoutesEnum.snowMan.path),
                ),
                ListItem(
                  title: '【动画】之478呼吸法',
                  subtitle: '【动画】之478呼吸法',
                  icon: Icons.tab_rounded,
                  onTap: () => Get.toNamed(RoutesEnum.breathingMethod.path),
                ),
                ListItem(
                  title: 'form表单验证',
                  subtitle: 'form表单验证',
                  icon: Icons.tab_rounded,
                  onTap: () => Get.toNamed(RoutesEnum.completeForm.path),
                ),
                ListItem(
                  title: '【手势】之弹簧',
                  subtitle: '【手势】之弹簧',
                  icon: Icons.tab_rounded,
                  onTap: () => Get.toNamed(RoutesEnum.gestureSpring.path),
                ),
                ListItem(
                  title: '通讯录',
                  subtitle: '通讯录',
                  icon: Icons.tab_rounded,
                  onTap: () => Get.toNamed(RoutesEnum.contactList.path),
                ),
                ListItem(
                  title: '文件预览',
                  subtitle: '文件预览',
                  icon: Icons.tab_rounded,
                  onTap: () => Get.toNamed(RoutesEnum.filePreview.path, arguments: {"path": "https://gstory.vercel.app/ceshi/ceshi.pdf"}),
                ),
                ListItem(
                  title: '视频播放',
                  subtitle: '视频播放',
                  icon: Icons.tab_rounded,
                  onTap: () => Get.toNamed(RoutesEnum.videoPlayer.path),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
