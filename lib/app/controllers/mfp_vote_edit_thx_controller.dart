import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/base_model.dart';
import '../ui/utils/log.dart';
import '../ui/utils/storage_keys.dart';
import '../data/services/vote_service.dart';
import '../data/models/edit_vote_item_model.dart';

class MfpVoteEditThxController extends GetxController {
  final _service = VoteService();
  final _box = GetStorage();

  final EditVoteItemModel _data = Get.arguments['DATA'];

  var editVoteItemModel = EditVoteItemModel().obs;

  late TextEditingController thxController;

  @override
  void onInit() {
    editVoteItemModel.value = _data;
    Log.print(jsonEncode(_data.toJson()));

    thxController = TextEditingController(text: _data.service ?? 'ขอขอบคุณสำหรับเวลาและการโหวตของท่าน');
    super.onInit();
  }

  Future<BaseModel> fetchEditVoting() async {
    try {
      String token = _box.read(StorageKeys.token) ?? '';
      String uid = _box.read(StorageKeys.uid) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      Response response = await _service.editVoting(
        voteId: editVoteItemModel.value.id!,
        token: token,
        uid: uid,
        mode: mode,
        editVoteItemModel: editVoteItemModel.value,
      );

      BaseModel model = BaseModel.fromJson(response.body);

      switch (model.message) {
        case 'You have been banned.':
          model.message = 'คุณถูกระงับการใช้งาน';
          break;

        case 'Not found the user.':
          model.message = 'ไม่พบผู้ใช้งาน';
          break;

        case 'Cannot find a vote.':
          model.message = 'ไม่พบโหวต';
          break;

        case 'Status is voted.':
          model.message = 'สถานะโหวตเป็น "โหวตแล้ว"';
          break;

        case 'The vote was approved.':
          model.message = 'โหวตได้รับการอนุมัติแล้ว';
          break;

        case 'The vote was closed.':
          model.message = 'โหวตได้รับการปิดแล้ว';
          break;

        case 'Found special characters in title what you wrote.':
          model.message = 'พบอักขระพิเศษในหัวข้อที่คุณเขียน';
          break;

        case 'Found special characters in detail what you wrote.':
          model.message = 'พบอักขระพิเศษในรายละเอียดที่คุณเขียน';
          break;

        case 'The number of VoteItem exceeds the maximum configured for VoteQuestion.':
          model.message = 'จำนวนคำถามเกินจำนวนสูงสุดที่กำหนดไว้';
          break;

        case 'The number of VoteChoice exceeds the maximum configured for VoteChoice.':
          model.message = 'จำนวนคำตอบเกินจำนวนสูงสุดที่กำหนดไว้';
          break;

        case 'Cannot update a VoteEvent.':
          model.message = 'ไม่สามารถอัปเดต VoteEvent';
          break;

        default:
          model.message = 'แก้ไขโหวตสำเร็จ';
          break;
      }

      return model;
    } catch (e) {
      return BaseModel(
        status: 0,
        message: 'ไม่สามารถแก้ไขโหวตได้',
      );
    }
  }
}
