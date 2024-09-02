import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/services/user_service.dart';
import '../ui/utils/storage_keys.dart';

class SettingController extends GetxController {
  final _service = UserService();
  final _box = GetStorage();

  Future<bool> fetchDeleteAccountUser() async {
    try {
      String uid = _box.read(StorageKeys.uid) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';

      _service.deleteAccountUser(
        uid: uid,
        mode: mode,
        token: token,
      );

      await 3.seconds.delay();

      return true;
/* 
      Response response = await _service.deleteAccountUser(
        uid: uid,
        mode: mode,
        token: token,
      );

      if (response.isOk) {
        await _box.erase();

        return true;
      } else {
        throw Exception(response.statusText ?? 'ขออภัย เกิดข้อผิดพลาดในการเชื่อมต่อระบบ');
      } */
    } catch (e) {
      log('', error: e, name: 'FetchDeleteAccountUser');
      return false;
    }
  }
}
