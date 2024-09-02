import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/manipulate_model.dart';
import '../data/services/user_service.dart';
import '../ui/utils/storage_keys.dart';

class UserGeneratedContentController extends GetxController {
  final _service = UserService();
  final _box = GetStorage();

  TextEditingController msgReportTextController = TextEditingController();

  ManipulateModel manipulateUserModel = ManipulateModel();
  ManipulateModel manipulatePostModel = ManipulateModel();
  ManipulateModel manipulatePageModel = ManipulateModel();

  Future<void> fetchHidePost(String postId) async {
    try {
      String uid = _box.read(StorageKeys.uid) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      await _service.hidePost(
        uid: uid,
        token: token,
        mode: mode,
        postId: postId,
      );
    } catch (e) {
      printError(info: e.toString());
    }

    update();
    return;
  }

  Future<ManipulateModel> fetchManipulateUser() async {
    try {
      Response response = await _service.getManipulateUser();

      if (response.isOk) {
        manipulateUserModel = ManipulateModel.fromJson(response.body);
      } else {
        manipulateUserModel.clear();
      }
    } catch (e) {
      manipulateUserModel.clear();
      printError(info: e.toString());
    }

    update();
    return manipulateUserModel;
  }

  Future<ManipulateModel> fetchManipulatePost() async {
    try {
      Response response = await _service.getManipulatePost();

      if (response.isOk) {
        manipulatePostModel = ManipulateModel.fromJson(response.body);
      } else {
        manipulatePostModel.clear();
      }
    } catch (e) {
      manipulatePostModel.clear();
      printError(info: e.toString());
    }

    update();
    return manipulatePostModel;
  }

  Future<ManipulateModel> fetchManipulatePage() async {
    try {
      Response response = await _service.getManipulatePage();

      if (response.isOk) {
        manipulatePageModel = ManipulateModel.fromJson(response.body);
      } else {
        manipulatePageModel.clear();
      }
    } catch (e) {
      manipulatePageModel.clear();
      printError(info: e.toString());
    }

    update();
    return manipulatePageModel;
  }

  Future<void> fetchReportPostPageUser({
    required String id,
    required String type,
    required String topic,
    required String message,
  }) async {
    try {
      String uid = _box.read(StorageKeys.uid) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      await _service.reportPostPageUser(
        uid: uid,
        token: token,
        mode: mode,
        id: id,
        type: type,
        topic: topic,
        message: message,
      );
    } catch (e) {
      printError(info: e.toString());
    }

    msgReportTextController.clear();
    update();
    return;
  }

  Future<void> fetchBlockPageUser({
    required String id,
    required String type,
  }) async {
    try {
      String uid = _box.read(StorageKeys.uid) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      await _service.blockPageUser(
        id: id,
        type: type,
        token: token,
        uid: uid,
        mode: mode,
      );
    } catch (e) {
      printError(info: e.toString());
    }

    update();
    return;
  }
}
