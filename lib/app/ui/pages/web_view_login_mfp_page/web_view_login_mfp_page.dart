// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controllers/web_view_login_mfp_controller.dart';
import '../../../data/models/base_model.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/colors.dart';
import '../../utils/storage_keys.dart';

class WebViewLoginMfpPage extends GetView<WebViewLoginMfpController> {
  WebViewLoginMfpPage({super.key});

  @override
  WebViewLoginMfpController controller = Get.put(WebViewLoginMfpController());

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () => Get.back(result: null),
          icon: const Icon(Icons.arrow_back_ios),
        ),
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
              ..setNavigationDelegate(NavigationDelegate(
                onNavigationRequest: _navigationDelegate,
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
              ))
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

  Future<NavigationDecision> _navigationDelegate(NavigationRequest navigation) async {
    final url = Uri.decodeComponent(navigation.url);
    log('NAVIGATION_URL: $url');

    /// Login With MFP
    // bool isLoginSuccess = _url.startsWith('https://accounts.moveforwardparty.org/account/login/callback?token=');
    // if (isLoginSuccess) {
    //   Get.offAllNamed(AppRoutes.SPLASH);
    // }

    /// Binding MerberShip MFP
    bool isProcessing = url.startsWith('https://today.peoplesparty.or.th/processing');
    bool isProcessingAct = url.startsWith('https://today.peoplesparty.or.th/process/act');

    debugPrint("_url : $url", wrapWidth: 1024);
    if (isProcessing) {
      debugPrint("isProcessing : true", wrapWidth: 1024);
      String queryEncode = url.replaceFirst('https://today.peoplesparty.or.th/processing?', '');

      Map queryMap = Uri.splitQueryString(queryEncode);
      debugPrint("queryMap : $queryMap", wrapWidth: 1024);

      BaseModel result = await controller.fetchBindingMember(queryMap['token']);

      debugPrint('RESULT.MESSAGE: ${result.message}', wrapWidth: 1024);
      switch (result.message) {
        case 'Binding User Is Successful.':
          Get.back(result: 'ผูกสมาชิกสำเร็จ');
          break;

        case 'PENDING_PAYMENT':
          Get.back(result: 'รอการชำระเงิน');
          break;

        case 'PENDING_APPROVAL':
          Get.back(result: 'รอการตรวจสอบ');
          break;

        case 'REJECTED':
          Get.back(result: 'ไม่ผ่านการตรวจสอบ');
          break;

        case 'PROFILE_RECHECKED':
          Get.back(result: 'สมาชิกรอจัดเก็บ');
          break;

        case 'ARCHIVED':
          Get.back(result: 'สมาชิกที่จัดเก็บแล้ว');
          break;

        case 'You have ever binded this user.':
          Get.back(result: 'คุณเคยผูกสมาชิกไปแล้ว');
          break;

        case 'You have binded this user.':
          Get.back(result: 'คุณเคยผูกสมาชิกไปแล้ว');
          break;

        case 'Cannot Update Status Membership User.':
          Get.back(result: 'ไม่สามารถผูกสมาชิกได้');
          break;

        default:
          Get.back(result: 'ไม่พบบัญชีผู้ใช้');
          break;
      }
    } else if (isProcessingAct) {
      debugPrint("isProcessingAct : true", wrapWidth: 1024);
      String queryEncode = url.replaceFirst('https://today.peoplesparty.or.th/process/act?', '');
      Map queryMap = Uri.splitQueryString(queryEncode);

      if (queryMap['actid'] == null || queryMap['actid'].isEmpty) {
        Get.back(result: 'ผูกสมาชิกไม่สำเร็จ');
        return NavigationDecision.prevent;
      }

      GetStorage box = GetStorage();
      await box.write(StorageKeys.uidAct, queryMap['actid']);

      Get.back(result: 'ผูกสมาชิกสำเร็จ');
    }

    return NavigationDecision.navigate;
  }
}
