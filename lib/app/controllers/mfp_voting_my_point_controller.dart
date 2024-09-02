import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/vote_choice_model.dart';
import '../data/models/voting_own_model.dart';
import '../data/services/vote_service.dart';
import '../ui/utils/log.dart';
import '../ui/utils/storage_keys.dart';

class MfpVotingMyPointController extends GetxController {
  final _service = VoteService();
  final _box = GetStorage();

  final String voteId = Get.arguments['VOTE_ID'];

  var votingOwn = VotingOwnModel().obs;
  var voteChoiceModel = VoteChoiceModel().obs;

  @override
  void onInit() {
    Log.print('voteId: $voteId');
    super.onInit();
  }

  @override
  void onReady() {
    fetchGetVotingOwn();
    fetchGetVoteResults();
    super.onReady();
  }

  Future<void> fetchGetVoteResults() async {
    String token = _box.read(StorageKeys.token) ?? '';
    if (token.isEmpty) return;

    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _service.getVoting(
        voteId: voteId,
        uid: uid,
        token: token,
        mode: mode,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VoteChoiceModel.fromJson(response.body);

      if (model.status == 0) throw Exception(model.message ?? 'Error');

      if ((model.data?.voteItem ?? []).isNotEmpty) {
        /// sort ordering
        model.data!.voteItem!.sort((a, b) => a.ordering!.compareTo(b.ordering!));

        voteChoiceModel(model);
      } else {
        // TODO: No data
      }
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteChoice');
      // TODO catch error
    }

    voteChoiceModel.refresh();
    return;
  }

  Future<void> fetchGetVotingOwn() async {
    String token = _box.read(StorageKeys.token) ?? '';
    if (token.isEmpty) return;

    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _service.getVotingOwn(
        voteId: voteId,
        uid: uid,
        token: token,
        mode: mode,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VotingOwnModel.fromJson(response.body);

      if (model.status == 0) throw Exception(model.message ?? 'Error');

      votingOwn(model);
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteChoice');
      // TODO catch error
    }

    votingOwn.refresh();
    return;
  }
}
