// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';
import 'dart:math' as rd;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as storage;

import '../data/models/vote_choice_model.dart' as c;
import '../data/models/voting_model.dart';
import '../data/services/vote_service.dart';
import '../ui/utils/enum.dart';
import '../ui/utils/storage_keys.dart';
import 'mfp_vote_dashboard_controller.dart';

class MfpVoteController extends GetxController {
  final _service = VoteService();
  final _box = storage.GetStorage();

  final String voteId = Get.arguments['VOTE_ID'];
  final List<c.VoteItem> _data = Get.arguments['DATA'];
  final String service = Get.arguments['SERVICE'];

  var textController = TextEditingController().obs;

  var dataModel = c.VoteChoiceModel().obs;
  var votingModel = VotingModel().obs;

  int number = 1;

  @override
  void onInit() {
    dataModel.update((val) {
      val!.status = 1;
      val.message = 'Success';
      val.data = c.Data(
        voteItem: _data,
        voted: [],
        voteCount: 0,
      );
    });
    dataModel.value.data!.voteItem!.forEach((data) {
      data.voteChoice!.forEach((voteChoice) {
        voteChoice.isSelect = false;
      });
    });
    super.onInit();
  }

  @override
  void onClose() {
    textController.value.dispose();
    dataModel.close();
    votingModel.close();
    super.onClose();
  }

  final _index = 0.obs;
  int get index => _index.value;
  set index(int value) => _index.value = value;

  void randomNumber() {
    number = rd.Random().nextInt(8) + 1;
    update();
  }

  void selectChoice({
    required VoteChoiceType voteChoiceType,
    required String voteItemId,
    required String answer,
    required String voteChoiceId,
    required bool isSelect,
  }) {
    switch (voteChoiceType) {
      case VoteChoiceType.single:
        var voteItem = votingModel.value.voteItem ?? [];

        if (isSelect) {
          voteItem.where((element) => element.voteItemId == voteItemId).isEmpty
              ? voteItem.add(
                  VoteItem(
                    voteItemId: voteItemId,
                    voteChoice: [
                      VoteChoices(
                        answer: answer,
                        voteChoiceId: voteChoiceId,
                      ),
                    ],
                  ),
                )
              : voteItem.where((element) => element.voteItemId == voteItemId).first.voteChoice = [
                  VoteChoices(
                    answer: answer,
                    voteChoiceId: voteChoiceId,
                  ),
                ];
        } else {
          voteItem.removeWhere((element) => element.voteItemId == voteItemId);
        }

        votingModel.value.voteItem = voteItem;
        break;

      case VoteChoiceType.multi:
        var voteItem = votingModel.value.voteItem ?? [];

        if (isSelect) {
          voteItem.where((element) => element.voteItemId == voteItemId).isEmpty
              ? voteItem.add(
                  VoteItem(
                    voteItemId: voteItemId,
                    voteChoice: [
                      VoteChoices(
                        answer: answer,
                        voteChoiceId: voteChoiceId,
                      ),
                    ],
                  ),
                )
              : voteItem.where((element) => element.voteItemId == voteItemId).first.voteChoice!.add(
                    VoteChoices(
                      answer: answer,
                      voteChoiceId: voteChoiceId,
                    ),
                  );
        } else {
          voteItem.where((element) => element.voteItemId == voteItemId).first.voteChoice!.removeWhere(
                (element) => element.voteChoiceId == voteChoiceId,
              );
        }

        votingModel.value.voteItem = voteItem;
        break;

      case VoteChoiceType.text:
        var voteItem = votingModel.value.voteItem ?? [];

        if (answer.isNotEmpty) {
          voteItem.where((element) => element.voteItemId == voteItemId).isEmpty
              ? voteItem.add(
                  VoteItem(
                    voteItemId: voteItemId,
                    answer: answer,
                    voteChoice: [],
                  ),
                )
              : voteItem.where((element) => element.voteItemId == voteItemId).first.answer = answer;
        } else {
          voteItem.removeWhere((element) => element.voteItemId == voteItemId);
        }

        votingModel.value.voteItem = voteItem;
        break;
    }
  }

  Future<void> fetchSendVotePoint() async {
    String token = _box.read(StorageKeys.token) ?? '';
    if (token.isEmpty) return;

    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      MfpVoteDashboardController dashboardController = Get.put(MfpVoteDashboardController());

      Response response = await _service.postSendVotePoint(
        voteId: voteId,
        token: token,
        uid: uid,
        mode: mode,
        votingModel: votingModel.value,
      );

      dashboardController.fetchGetVoteMainContents();
      dashboardController.fetchGetVotemyCreate();
      dashboardController.fetchGetVoteSupport();
      dashboardController.fetchGetVoteOpen();
      dashboardController.fetchGetVoteResults();

      // if (response.hasError) throw Exception(response.statusText ?? 'Error');

      // final model = VoteChoiceModel.fromJson(response.body);

      // if (model.status == 0) throw Exception(model.message ?? 'Error');

      // if ((model.data ?? []).isNotEmpty) {
      //   /// sort ordering
      //   model.data!.sort((a, b) => a.ordering!.compareTo(b.ordering!));

      //   voteChoiceModel(model);
      // } else {
      //   // TODO: No data
      // }
    } catch (e) {
      log('', error: e, name: 'fetchSendVotePoint');
      // TODO catch error
    }

    // voteChoiceModel.refresh();
    return;
  }
}
