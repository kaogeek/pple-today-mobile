import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/base_model.dart';
import '../data/services/user_service.dart';
import '../ui/utils/storage_keys.dart';

class WebViewLoginMfpController extends GetxController {
  final _service = UserService();
  final _box = GetStorage();

  String title = Get.arguments['TITLE'];
  String url = Get.arguments['URL'];
  // String title = Get.arguments['TITLE'];

  double isProgress = 0.0;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    log('URL: $url');
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
