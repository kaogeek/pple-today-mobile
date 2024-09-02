import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controllers/webview_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/colors.dart';

class WebviewPage extends GetView<WebviewController> {
  WebviewPage({Key? key}) : super(key: key);

  @override
  WebviewController controller = Get.put(WebviewController());

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
      body: GetBuilder<WebviewController>(
        init: WebviewController(),
        initState: (_) {},
        builder: (_) {
          return Stack(
            children: [
              WebView(
                initialUrl: controller.url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  controller.isLoading = false;
                  controller.update();
                },
                onProgress: (progress) {
                  controller.isProgress = progress / 100;
                  controller.update();
                },
              ),
              if (controller.isLoading)
                LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    kPrimaryColor,
                  ),
                  value: controller.isProgress,
                ),
            ],
          );
        },
      ),
    );
  }
}
