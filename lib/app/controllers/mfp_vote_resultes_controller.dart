import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/vote_choice_model.dart';
import '../data/services/vote_service.dart';
import '../ui/utils/log.dart';
import '../ui/utils/storage_keys.dart';

class MfpVoteResultesController extends GetxController {
  final _service = VoteService();
  final _box = GetStorage();

  final String voteId = Get.arguments['VOTE_ID'];
  final bool memberType = Get.arguments['MEMBER_TYPE'];
  final bool? showVoterName = Get.arguments['SHOW_VOTER_NAME'];

  var voteChoiceModel = VoteChoiceModel().obs;

  @override
  void onInit() {
    Log.print('voteId: $voteId');
    super.onInit();
  }

  @override
  void onReady() {
    fetchGetVoteResults();
    super.onReady();
  }

  Future<void> fetchGetVoteResults() async {
    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';
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
}
