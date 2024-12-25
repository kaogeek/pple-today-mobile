import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../data/models/base_model.dart';
import '../data/services/user_service.dart';
import '../ui/utils/storage_keys.dart';

class WebViewLoginMfpController extends GetxController {
  final _service = UserService();
  final _box = GetStorage();

  String title = Get.arguments['TITLE'];
  String url = Get.arguments['URL'];
  // String title = Get.arguments['TITLE'];

  RxDouble isProgress = 0.0.obs;
  RxBool isLoading = true.obs;

//   final CookieManager _cookieManager = CookieManager();

  @override
  void onInit() {
    log('URL: $url');
    // if (GetPlatform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // webViewController = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setNavigationDelegate(NavigationDelegate(
    //     onPageStarted: (_) {
    //       isLoading = false;
    //       update();
    //     },
    //     onPageFinished: (_) {
    //       isLoading = false;
    //       update();
    //     },
    //     onProgress: (progress) {
    //       isProgress = progress / 100;
    //       update();
    //     },
    //   ))
    //   ..loadRequest(Uri.parse(url));
    super.onInit();
  }

  @override
  void onClose() {
    _clearCache();
    super.onClose();
  }

  Future<void> _clearCache() async {
    // await webViewController.clearCache(); // ล้างแคช
    // final cookiesCleared = await _cookieManager.clearCookies(); // ล้าง cookies
    // if (cookiesCleared) {
    //   debugPrint("Cookies cleared.");
    // } else {
    //   debugPrint("No cookies to clear.");
    // }
  }

  Future<BaseModel> fetchBindingMember(String tokenMFP) async {
    try {
      String uid = _box.read(StorageKeys.uid) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      Response response = await _service.bindingMember(
        tokenMFP: tokenMFP,
        uid: uid,
        token: token,
        mode: mode,
      );

      return BaseModel.fromJson(response.body);
    } catch (e) {
      log('', error: e);
      return BaseModel(
        status: 0,
        message: e.toString(),
        data: null,
      );
    }
  }
}
