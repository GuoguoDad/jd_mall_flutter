import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';

import 'package:jd_mall_flutter/component/common_header.dart';
import 'package:file_preview/file_preview.dart';

class FilePreviewPage extends StatefulWidget {
  final Map arguments;

  const FilePreviewPage({super.key, required this.arguments});

  @override
  State<FilePreviewPage> createState() => _FilePreviewPageState();
}

class _FilePreviewPageState extends State<FilePreviewPage> {
  FilePreviewController controller = FilePreviewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          commonHeader(context, title: "CustomPointer Demo"),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: FilePreviewWidget(
                    controller: controller,
                    width: getScreenWidth(context),
                    height: 600,
                    path: widget.arguments['path'],
                    callBack: FilePreviewCallBack(onShow: () {
                      print("文件打开成功");
                    }, onDownload: (progress) {
                      print("文件下载进度$progress");
                    }, onFail: (code, msg) {
                      print("文件打开失败 $code  $msg");
                    }),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        controller.showFile("https://gstory.vercel.app/ceshi/ceshi.docx");
                      },
                      child: const Text("docx"),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.showFile("https://gstory.vercel.app/ceshi/ceshi.pdf");
                      },
                      child: const Text("pdf"),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.showFile("https://gstory.vercel.app/ceshi/ceshi.xisx");
                      },
                      child: const Text("xisx"),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.showFile("https://gstory.vercel.app/ceshi/ceshi.txt");
                      },
                      child: const Text("txt"),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.showFile("https://gstory.vercel.app/ceshi/ceshi.pptx");
                      },
                      child: const Text("ppt"),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
