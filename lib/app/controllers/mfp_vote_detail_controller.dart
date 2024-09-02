import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../component/loading.dart';
import '../component/my_dialog.dart';
import '../data/models/user_support_vote_model.dart';
import '../data/models/vote_choice_model.dart';
import '../data/models/voting_own_model.dart';
import '../data/services/vote_service.dart';
import '../ui/utils/log.dart';
import '../ui/utils/storage_keys.dart';
import 'mfp_vote_dashboard_controller.dart';

class MfpVoteDetailController extends GetxController {
  final _service = VoteService();
  final _box = GetStorage();

  final String pageId = Get.arguments['PAGE_ID'];
  final String pageName = Get.arguments['PAGE_NAME'];
  final String pageImage = Get.arguments['PAGE_IMAGE'];
  final String voteId = Get.arguments['VOTE_ID'];
  final String voteImage = Get.arguments['VOTE_IMAGE'];
  final String voteTitle = Get.arguments['VOTE_TITLE'];
  final String voteDetail = Get.arguments['VOTE_DETAIL'];
  final String voteTimeOut = Get.arguments['VOTE_TIME_OUT'];
  final DateTime endDateTime = Get.arguments['END_DATE_TIME'];
  final String status = Get.arguments['STATUS'];
  final String hashTag = Get.arguments['HASHTAG'];
  final bool memberType = Get.arguments['MEMBER_TYPE'];
  final bool close = Get.arguments['CLOSE'];
  final String service = Get.arguments['SERVICE'];
  final RxBool mySupport = (Get.arguments['MY_SUPPORT'] as bool).obs;
  final int minminSupport = Get.arguments['MIN_SUPPORT'];
  final RxInt countSupport = (Get.arguments['COUNT_SUPPORT'] as int).obs;
  final int number = Get.arguments['NUMBER'];

  final int userCount = 5;

  var votingOwn = VotingOwnModel().obs;
  var voteChoiceModel = VoteChoiceModel().obs;
  var userSupportVoteModel = UserSupportVoteModel().obs;

  @override
  void onInit() {
    Log.print('voteId: $voteId');
    Log.print('hashTag: $hashTag');
    super.onInit();
  }

  @override
  void onReady() {
    fetchGetVotingOwn();
    fetchGetVoting();
    fetchGetUserSupportVote();
    super.onReady();
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

  Future<void> fetchGetVoting() async {
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

      if ((model.data!.voteItem ?? []).isNotEmpty) {
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

  Future<void> fetchGetUserSupportVote() async {
    String token = _box.read(StorageKeys.token) ?? '';
    if (token.isEmpty) return;

    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';
    try {
      Response response = await _service.getUserSupportVote(
        voteId: voteId,
        uid: uid,
        token: token,
        mode: mode,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = UserSupportVoteModel.fromJson(response.body);

      if (model.status == 0) throw Exception(model.message ?? 'Error');

      if ((model.data!.userSupport ?? []).isNotEmpty) {
        /// sort createdDate
        model.data!.userSupport!.sort((a, b) => b.createdDate!.compareTo(a.createdDate!));

        userSupportVoteModel(model);
      } else {
        // TODO: No data
      }
    } catch (e) {
      log('', error: e, name: 'fetchGetUserSupportVote');
      // TODO catch error
    }

    voteChoiceModel.refresh();
    return;
  }

  Future<void> fetchSupportVote() async {
    Loading.show();

    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    Response response = await _service.supportVote(
      voteId: voteId,
      uid: uid,
      token: token,
      mode: mode,
    );

    MfpVoteDashboardController mfpVoteDashboardController = Get.put(MfpVoteDashboardController());

    if (response.isOk) {
      await mfpVoteDashboardController.fetchGetVoteMainContents();
      await mfpVoteDashboardController.fetchGetVotemyCreate();
      await mfpVoteDashboardController.fetchGetVoteOpen();
      await mfpVoteDashboardController.fetchGetVoteSupport();
      await mfpVoteDashboardController.fetchGetVoteResults();
      await fetchGetUserSupportVote();

      countSupport(countSupport.value + 1);
      mySupport(true);

      Loading.dismiss();

      MyDialog.defaultDialog(
        title: 'สนับสนุนเรียบร้อย',
        content: 'คุณได้สนับสนุนโหวตนี้เรียบร้อยแล้ว',
        textConfirm: 'ตกลง',
        onConfirm: () => Get.back(),
      );
    } else {
      if (response.body['message'] == 'You have been supported.') {
        MyDialog.defaultDialog(
          content: 'คุณได้สนับสนุนโหวตนี้ไปแล้ว',
          textConfirm: 'ตกลง',
          onConfirm: () => Get.back(),
        );

        await mfpVoteDashboardController.fetchGetVoteMainContents();
        await mfpVoteDashboardController.fetchGetVotemyCreate();
        await mfpVoteDashboardController.fetchGetVoteOpen();
        await mfpVoteDashboardController.fetchGetVoteSupport();
        await mfpVoteDashboardController.fetchGetVoteResults();
        await fetchGetUserSupportVote();
      }
      Loading.dismiss();
    }

    return;
  }

  Future<void> fetchUnSupportVote() async {
    MyDialog.defaultDialog(
      title: 'ยกเลิกสนับสนุน',
      content: 'คุณต้องการยกเลิกสนับสนุนโหวตนี้ใช่หรือไม่',
      textConfirm: 'ยืนยัน',
      textCancel: 'ยกเลิก',
      onConfirm: () async {
        Get.back();

        Loading.show();

        String uid = _box.read(StorageKeys.uid) ?? '';
        String token = _box.read(StorageKeys.token) ?? '';
        String mode = _box.read(StorageKeys.mode) ?? '';

        Response response = await _service.unSupportVote(
          voteId: voteId,
          uid: uid,
          token: token,
          mode: mode,
        );

        if (response.isOk) {
          MfpVoteDashboardController mfpVoteDashboardController = Get.put(MfpVoteDashboardController());
          await mfpVoteDashboardController.fetchGetVoteMainContents();
          await mfpVoteDashboardController.fetchGetVotemyCreate();
          await mfpVoteDashboardController.fetchGetVoteOpen();
          await mfpVoteDashboardController.fetchGetVoteSupport();
          await mfpVoteDashboardController.fetchGetVoteResults();
          userSupportVoteModel.value.data!.userSupport!.removeWhere((element) => element.user!.id == uid);
          userSupportVoteModel.refresh();

          countSupport(countSupport.value - 1);
          mySupport(false);
          Loading.dismiss();
        } else {
          Loading.dismiss();
        }

        return;
      },
    );
  }
}
