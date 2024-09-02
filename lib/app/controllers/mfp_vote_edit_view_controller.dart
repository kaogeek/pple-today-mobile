// ignore_for_file: prefer_null_aware_operators

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/edit_vote_item_model.dart';
import '../data/services/vote_service.dart';
import '../ui/utils/environment.dart';
import '../ui/utils/log.dart';
import '../ui/utils/storage_keys.dart';

class MfpVoteEditViewController extends GetxController {
  final _service = VoteService();
  final _box = GetStorage();

  final _data = Get.arguments['DATA'];

  ScrollController scrollController = ScrollController();

  var editVoteItemModel = EditVoteItemModel().obs;

  @override
  void onInit() {
    Log.print('VOTE_ID: ${_data.id}');
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        print('scroll to end');
      }
    });

    fetchGetVoting();

    editVoteItemModel.update((val) {
      val!.id = _data.id;
      val.title = _data.title;
      val.detail = _data.detail;
      val.assetId = _data.voteImage == null ? null : _data.voteImage.toString().replaceFirst('${Environment.apiURL}/api', '').replaceAll('/image', '').split('/').last;
      val.coverPageUrl = _data.voteImage == null ? null : _data.voteImage.toString().replaceFirst('${Environment.apiURL}/api', '').replaceAll('/image', '');
      val.s3CoverPageUrl = _data.s3CoverPageUrl;
      val.hashTag = _data.hashTag;
      val.service = _data.service;
      val.showVoteName = _data.showVoterName;
      val.showVoteResult = _data.showVoteResult;
      val.voteDaysRange = _data.voteDaysRange;
      if (_data.user != null) {
        val.user = User1(
          id: _data.user.id,
          email: _data.user.email,
          name: _data.user.name,
          firstName: _data.user.firstName,
          lastName: _data.user.lastName,
          imageUrl: _data.user.imageUrl,
        );
      }
      if (_data.page != null) {
        val.page = Page1(
          id: _data.page.id,
          name: _data.page.name,
          pageUsername: _data.page.pageUsername,
          imageUrl: _data.page.imageUrl,
          isOfficial: _data.page.isOfficial,
          banned: _data.page.banned,
        );
      }
      val.delete = [];
      val.deleteChoices = [];
    });

    // editVoteItemModel.value.voteItem!.sort((a, b) => a.ordering!.compareTo(b.ordering!));

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> fetchGetVoting() async {
    String token = _box.read(StorageKeys.token) ?? '';
    if (token.isEmpty) return;

    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _service.getVoting(
        voteId: _data.id,
        uid: uid,
        token: token,
        mode: mode,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      editVoteItemModel.update((val) {
        val!.voteItem = EditVoteItemModel.fromJson(response.body['data']).voteItem;
      });

      /// sort ordering a-z
      // editVoteItemModel.update((val) {
      //   val!.voteItem!.sort((a, b) => a.ordering!.compareTo(b.ordering!));
      // });
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteChoice');
      // TODO catch error
    }

    editVoteItemModel.refresh();
    return;
  }
}
