import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../component/loading.dart';
import '../component/my_dialog.dart';
import '../data/models/base_model.dart';
import '../data/services/user_service.dart';
import '../routes/app_routes.dart';
import '../ui/utils/storage_keys.dart';
import 'login_main_controller.dart';
import 'profile_controller.dart';

class ConnectSocialMediaController extends GetxController {
  final _service = UserService();
  final _box = GetStorage();

  bool autoTapBinding = Get.arguments == null ? false : Get.arguments['AUTO_TAP_BINDING'] ?? false;

  LoginMainController loginMainController = Get.put(LoginMainController());

  @override
  void onReady() {
    super.onReady();
    if (autoTapBinding) fetchBindingMFP();
    // showAlertDialog();
  }

//   void showAlertDialog() {
//     MyDialog.defaultDialog(
//       title: 'สร้างบัญชี',
//       content: 'ต้องการสร้างบัญชีบน ระบบ Act หรือไม่ ?',
//       textConfirm: 'ตกลง',
//       textCancel: 'ยกเลิก',
//       onConfirm: () {
//         fetchBindingMFP();
//       },
//     );
//   }

  Future<void> fetchLoginWithFacebook() async {
    await loginMainController.fetchLoginWithFacebook();
    return;
  }

  Future<void> fetchLoginWithGoogle() async {
    await loginMainController.fetchLoginWithGoogle();
    return;
  }

  Future<void> fetchBindingMFP() async {
    final token = (await fetchUpdataMemberShip(membership: true)).data;

    if ((token ?? '').isNotEmpty) {
      final _uri = Uri.https(
        'auth.moveforwardparty.org',
        'sso',
        {'client_id': '5', 'process_type': 'binding', 'token': token},
      );

      final _status = await Get.toNamed(
        AppRoutes.WEB_VIEW_LOGIN_MFP,
        arguments: {
          'TITLE': 'เชื่อมต่อกับ People\'s Party',
          'URL': _uri.toString(),
        },
      );

      debugPrint('_STATUS: $_status');
      if (_status == null) return;

      if (_status != 'ผูกสมาชิกสำเร็จ') {
        await MyDialog.defaultDialog(
          title: 'ไม่สำเร็จ',
          content: _status,
          textConfirm: 'ปิด',
          onConfirm: () {
            Get.back();
          },
        );
        return;
      }

      ProfileController profileController = Get.find();
      await profileController.fetchProfileUser();

      await _box.write(StorageKeys.memberShip, true);
      await MyDialog.defaultDialog(
        title: 'สำเร็จ',
        content: 'คุณได้ทำการผูกสมาชิกสำเร็จแล้ว',
        textConfirm: 'เสร็จสิ้น',
        onConfirm: () {
          Get.back();
        },
      );
    }

    return;
  }

  Future<BaseModel> fetchUpdataMemberShip({required bool membership}) async {
    Loading.show();
    try {
      String uid = _box.read(StorageKeys.uid) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      Response response = await _service.updataMemberShip(
        uid: uid,
        token: token,
        mode: mode,
        membership: membership,
      );

      Loading.dismiss();
      return BaseModel.fromJson(response.body);
    } catch (e) {
      log('', error: e);
    }

    Loading.dismiss();
    return BaseModel(
      status: 0,
      message: 'เกิดข้อผิดพลาดในการเชื่อมต่อ',
      data: null,
    );
  }

  Future<Map<String, dynamic>> fetchGetMD5HashKey() async {
    final _uid = _box.read(StorageKeys.uid) ?? '';

    Response response = await _service.md5HashKey(uid: _uid);

    if (response.hasError) {
      await MyDialog.defaultDialog(
        title: 'ไม่สำเร็จ',
        content: response.statusText,
        textConfirm: 'ปิด',
        onConfirm: () {
          Get.back();
        },
      );
      return {};
    }

    final _md5Key = response.body['Digest'] ?? '';

    final _queryParameters = {
      'today_uid': _uid,
      'token': _md5Key,
    };

    return _queryParameters;
  }
}
