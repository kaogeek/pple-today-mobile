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
  WebViewLoginMfpPage({Key? key}) : super(key: key);

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
      body: GetBuilder<WebViewLoginMfpController>(
        init: WebViewLoginMfpController(),
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
                navigationDelegate: _navigationDelegate,
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

  Future<NavigationDecision> _navigationDelegate(NavigationRequest navigation) async {
    final _url = Uri.decodeComponent(navigation.url);
    log('NAVIGATION_URL: $_url');

    /// Login With MFP
    // bool isLoginSuccess = _url.startsWith('https://accounts.moveforwardparty.org/account/login/callback?token=');
    // if (isLoginSuccess) {
    //   Get.offAllNamed(AppRoutes.SPLASH);
    // }

    /// Binding MerberShip MFP
    bool isProcessing = _url.startsWith('https://today.pplethai.org/processing');
    bool isProcessingAct = _url.startsWith('https://today.pplethai.org/process/act');

    if (isProcessing) {
      String queryEncode = _url.replaceFirst('https://today.pplethai.org/processing?', '');
      Map queryMap = Uri.splitQueryString(queryEncode);

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
      String queryEncode = _url.replaceFirst('https://today.pplethai.org/process/act?', '');
      Map queryMap = Uri.splitQueryString(queryEncode);

      if (queryMap['actid'] == null || queryMap['actid'].isEmpty) {
        Get.back(result: 'ผูกสมาชิกไม่สำเร็จ');
        return NavigationDecision.prevent;
      }

      GetStorage _box = GetStorage();
      await _box.write(StorageKeys.uidAct, queryMap['actid']);

      Get.back(result: 'ผูกสมาชิกสำเร็จ');
    }

    return NavigationDecision.navigate;
  }
}
