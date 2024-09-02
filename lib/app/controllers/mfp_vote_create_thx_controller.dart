import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/create_item_model.dart';
import '../data/services/vote_service.dart';
import '../ui/utils/storage_keys.dart';

class MfpVoteCreateThxController extends GetxController {
  final _service = VoteService();
  final _box = GetStorage();

  final CreateItemModel data = Get.arguments['DATA'];

  var createItemModel = CreateItemModel().obs;

  TextEditingController thxController = TextEditingController();

  @override
  void onInit() {
    createItemModel(data);
    super.onInit();
  }

  Future<bool> fetchCreateVote() async {
    String token = _box.read(StorageKeys.token) ?? '';
    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    bool asPage = (createItemModel.value.createAsPage ?? '').isNotEmpty;

    Response response = asPage
        ? await _service.createVoteAsPage(
            token: token,
            uid: uid,
            mode: mode,
            pageId: createItemModel.value.createAsPage,
            createItemModel: createItemModel.value,
          )
        : await _service.createVoteAsUser(
            token: token,
            uid: uid,
            mode: mode,
            createItemModel: createItemModel.value,
          );

    return response.status.hasError ? false : true;
  }
}
