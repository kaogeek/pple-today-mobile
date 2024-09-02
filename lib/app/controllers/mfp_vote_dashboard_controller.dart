import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../component/convert_time_componenet.dart';
import '../component/loading.dart';
import '../component/my_dialog.dart';
import '../data/models/vote_detail_model.dart';
import '../data/models/vote_main_contents_model.dart';
import '../data/models/vote_my_create_model.dart';
import '../data/models/vote_post_model.dart';
import '../data/services/vote_service.dart';
import '../routes/app_routes.dart';
import '../ui/utils/log.dart';
import '../ui/utils/storage_keys.dart';

class MfpVoteDashboardController extends GetxController {
  final _service = VoteService();
  final _box = GetStorage();
  final _dateNow = DateTime.now();

  var mainContentsVoteModel = VoteMainContentsModel().obs;
  var voteMyCreateModel = VoteMyCreateModel().obs;
  var openVoteModel = VotePostModel().obs;
  var supportVoteModel = VotePostModel().obs;
  var resultsVoteModel = VotePostModel().obs;

  var isLoadMoreRunning = false.obs;
  var isFinalLoadMore = false.obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        debugPrint('load more fetchGetVoteResults', wrapWidth: 1024);
        fetchGetVoteResults(offset: resultsVoteModel.value.data?.length ?? 0);
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    fetchGetVoteMainContents();
    fetchGetVotemyCreate();
    fetchGetVoteOpen();
    fetchGetVoteSupport();
    fetchGetVoteResults();
    super.onReady();
  }

  Future<void> fetchGetVoteDetail(String voteId) async {
    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _service.getVoteDetail(
        voteId: voteId,
        uid: uid,
        token: token,
        mode: mode,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VoteDetailModel.fromJson(response.body);

      if (model.status == 0) throw Exception(model.message ?? 'Error');

      dynamic page = model.data?.page ?? model.data!.user;
      dynamic endDatetime;
      late String voteTimeOut;

      if (model.data!.status == 'close') {
        endDatetime = DateTime.parse(model.data!.endSupportDatetime!);
        voteTimeOut = 'ปิดโหวตแล้ว';
      } else if (model.data!.status == 'support') {
        endDatetime = DateTime.parse(model.data!.endSupportDatetime!);
        voteTimeOut = 'ปิดลงชื่อใน ${ConvertTimeComponenet.between(endDatetime.toLocal(), _dateNow.toLocal())}';
      } else {
        endDatetime = DateTime.parse(model.data!.endVoteDatetime!);
        voteTimeOut = 'ปิดโหวตใน ${ConvertTimeComponenet.between(endDatetime.toLocal(), _dateNow.toLocal())}';
      }

      if (Get.currentRoute == AppRoutes.MFP_VOTE_DETAIL) Get.back();

      await 0.5.seconds.delay();

      Get.toNamed(
        AppRoutes.MFP_VOTE_DETAIL,
        arguments: {
          'PAGE_ID': page.id,
          'PAGE_NAME': page.name ?? '',
          'PAGE_IMAGE': page.imageUrl ?? '',
          'VOTE_ID': model.data!.id,
          'VOTE_IMAGE': model.data!.coverPageUrl ?? '',
          'VOTE_TITLE': model.data!.title ?? '',
          'VOTE_DETAIL': model.data!.detail ?? '',
          'VOTE_TIME_OUT': voteTimeOut,
          'END_DATE_TIME': model.data!.status == 'support' || model.data!.status == 'close'
              ? DateTime.parse(model.data!.endSupportDatetime ?? '')
              : DateTime.parse(model.data!.endVoteDatetime ?? ''),
          'STATUS': model.data!.status ?? '',
          'HASHTAG': model.data!.hashTag ?? '',
          'CLOSE': model.data!.closed ?? false,
          'SERVICE': model.data!.service ?? '',
          'MEMBER_TYPE': (model.data!.type ?? '') == 'member',
          'MY_SUPPORT': model.data!.userSupport ?? false,
          'MIN_SUPPORT': model.data!.minSupport,
          'COUNT_SUPPORT': model.data!.countSupport,
          'NUMBER': math.Random().nextInt(8) + 1,
        },
      );
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteDetail');
    }

    return;
  }

  Future<void> fetchGetVoteMainContents({int limit = 10, int offset = 0}) async {
    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';

    try {
      Response response = await _service.getVoteMainContents(
        token: token,
        uid: uid,
        mode: mode,
        limit: limit,
        offset: offset,
        pin: true,
        myVote: true,
        supporter: true,
        closeVote: true,
        closeDate: true,
        closetSupport: true,
        hashTagVote: true,
        generalSection: true,
        voteObjId: [],
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VoteMainContentsModel.fromJson(response.body);

      if (model.status == 0) throw Exception(model.message ?? 'Error');

      /// sort closeSupport endSupportDatetime a-z
      model.data?.closetSupport?.sort((a, b) => a.endSupportDatetime!.compareTo(b.endSupportDatetime!));

      /// sort hashTagVote id a-z
      model.data?.hashTagVote?.sort((a, b) => a.id!.compareTo(b.id!));

      await _box.write(StorageKeys.voteObjId, model.data?.voteObjId ?? []);

      mainContentsVoteModel(model);
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteMainContents');
      // TODO catch error
    }

    mainContentsVoteModel.refresh();
    return;
  }

  Future<void> fetchGetVotemyCreate({int limit = 10, int offset = 0}) async {
    String token = _box.read(StorageKeys.token) ?? '';
    if (token.isEmpty) return;

    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _service.getVoteMyCreate(
        token: token,
        uid: uid,
        mode: mode,
        limit: limit,
        offset: offset,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VoteMyCreateModel.fromJson(response.body);

      voteMyCreateModel(model);
    } catch (e) {
      log('', error: e, name: 'fetchGetVotemyCreate');
      // TODO catch error
    }

    voteMyCreateModel.refresh();
    return;
  }

  Future<void> fetchGetVoteOpen({
    int limit = 10,
    int offset = 0,
  }) async {
    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _service.getVoteOpen(
        uid: uid,
        token: token,
        mode: mode,
        keyword: '',
        limit: limit,
        offset: offset,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VotePostModel.fromJson(response.body);

      model.data!.sort((a, b) => a.endVoteDatetime!.compareTo(b.endVoteDatetime!));
      offset == 0
          ? openVoteModel(model)
          : openVoteModel.update((val) {
              val?.data?.addAll(model.data ?? []);
            });
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteOpen');
      // TODO catch error
    }

    openVoteModel.refresh();
    return;
  }

  Future<void> fetchGetVoteSupport({
    int limit = 10,
    int offset = 0,
  }) async {
    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _service.getVoteSupport(
        uid: uid,
        token: token,
        mode: mode,
        keyword: '',
        limit: limit,
        offset: offset,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VotePostModel.fromJson(response.body);
      Log.print('model: ${model.status}');

      offset == 0
          ? supportVoteModel(model)
          : supportVoteModel.update((val) {
              val?.data?.addAll(model.data ?? []);
            });
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteSupport');
      // TODO catch error
    }

    supportVoteModel.refresh();
    return;
  }

  Future<void> fetchGetVoteResults({
    int limit = 5,
    int offset = 0,
  }) async {
    if (isLoadMoreRunning.value || isFinalLoadMore.value) return;

    if (offset != 0) isLoadMoreRunning.value = true;

    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _service.getVoteResults(
        uid: uid,
        token: token,
        mode: mode,
        keyword: '',
        limit: limit,
        offset: offset,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VotePostModel.fromJson(response.body);

      offset == 0
          ? resultsVoteModel(model)
          : resultsVoteModel.update((val) {
              val?.data?.addAll(model.data ?? []);
            });
      resultsVoteModel.refresh();
      if ((model.data ?? []).length < limit) isFinalLoadMore.value = true;
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteResults');
      // TODO catch error
    }

    resultsVoteModel.refresh();
    isLoadMoreRunning.value = false;
    return;
  }

  Future<void> fetchDeleteVoting(String voteId) async {
    await MyDialog.defaultDialog(
      title: 'ยืนยันการลบโหวต',
      content: 'คุณต้องการลบโหวตนี้ใช่หรือไม่',
      contentColor: Colors.red,
      textConfirm: 'ยืนยัน',
      textCancel: 'ยกเลิก',
      onConfirm: () async {
        Get.back();

        Loading.show();
        String uid = _box.read(StorageKeys.uid) ?? '';
        String token = _box.read(StorageKeys.token) ?? '';
        String mode = _box.read(StorageKeys.mode) ?? '';

        Response response = await _service.deleteVoting(
          voteId: voteId,
          uid: uid,
          token: token,
          mode: mode,
        );

        if (response.isOk) {
          await fetchGetVoteMainContents();
          await fetchGetVotemyCreate();
          await fetchGetVoteOpen();
          await fetchGetVoteSupport();
          await fetchGetVoteResults();
        }

        Loading.dismiss();
      },
    );

    return;
  }
}
