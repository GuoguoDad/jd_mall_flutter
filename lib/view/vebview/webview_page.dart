// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// Package imports:
import 'package:webview_flutter/webview_flutter.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/view/vebview/type.dart';
import 'package:jd_mall_flutter/view/vebview/widget/floating_header.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<StatefulWidget> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;

  bool isInit = false;
  bool isLoading = true;
  String title = '';

  void initView() {
    if (isInit) return;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel("ARTICLE_SCROLL_CHANNEL", onMessageReceived: (msg) {
        if (double.parse(msg.message) > 100) {
        } else {}
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            controller.getTitle().then((value) => setState(() {
                  title = (value ?? "").replaceAll("京东", "");
                }));
            controller.runJavaScript(
              '''
                window.addEventListener('scroll', function() {
                window.ARTICLE_SCROLL_CHANNEL.postMessage(this.scrollY);
                });
              ''',
            );
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(Get.arguments['url'] ?? ""));
    isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    initView();

    Widget floatingLoading = Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
            width: getScreenWidth(context),
            height: getScreenHeight(context),
            child: loadingWidget(context),
          ),
        ),
        floatingHeader(context, title: title)
      ],
    );

    Widget webView = Stack(
      children: [
        WebViewWidget(controller: controller),
        floatingHeader(context, title: title),
      ],
    );

    return Scaffold(body: isLoading ? floatingLoading : webView);
  }
}
