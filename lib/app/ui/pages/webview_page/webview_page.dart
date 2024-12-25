import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controllers/webview_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/colors.dart';

class WebviewPage extends GetView<WebviewController> {
  const WebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          controller.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: textDark,
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    controller.isProgress.value = progress / 100;
                  },
                  onPageStarted: (String url) {
                    controller.isLoading.value = true;
                  },
                  onPageFinished: (String url) {
                    controller.isLoading.value = false;
                  },
                  onHttpError: (HttpResponseError error) {
                    debugPrint("HttpResponseError : $error", wrapWidth: 1024);
                  },
                  onWebResourceError: (WebResourceError error) {
                    debugPrint("WebResourceError : $error", wrapWidth: 1024);
                  },
                ),
              )
              ..loadRequest(Uri.parse(controller.url)),
          ),
          Obx(() => controller.isLoading.value
              ? LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  value: controller.isProgress.value,
                )
              : SizedBox.shrink()),
        ],
      ),
    );
  }
}
