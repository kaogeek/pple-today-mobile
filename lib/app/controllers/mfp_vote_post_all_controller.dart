import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as storage;

import '../data/models/vote_main_contents_model.dart';
import '../data/models/vote_my_create_model.dart';
import '../data/models/vote_post_model.dart';
import '../data/services/vote_service.dart';
import '../ui/utils/storage_keys.dart';

class MfpVotePostAllController extends GetxController {
  final _service = VoteService();
  final _box = storage.GetStorage();

  final String topic = Get.arguments['TOPIC'];
  final bool isResults = Get.arguments['IS_RESULTS'];
  final List data = Get.arguments['DATA'];

  ScrollController scrollController = ScrollController();

  var mainContentsVoteModel = VoteMainContentsModel().obs;
  List<String> voteObjId = storage.GetStorage().read(StorageKeys.voteObjId) ?? [];
  bool isLoadMoreRunning = false;
  bool isFinalLoadMore = false;

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) fetchLoadMore(offset: data.length);
    });
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    isLoadMoreRunning = false;
    isFinalLoadMore = false;
    voteObjId.clear();
    super.onClose();
  }

  Future<void> fetchLoadMore({int limit = 10, int offset = 0}) async {
    if (isLoadMoreRunning || isFinalLoadMore) return;

    isLoadMoreRunning = true;
    update();

    debugPrint('fetchLoadMore'.toUpperCase(), wrapWidth: 1024);

    /// ใส่ delay เพื่อให้โชว์ loading สักครู่
    await 0.5.seconds.delay();

    try {
      switch (topic) {
        case 'ปักหมุด':
          final model = await fetchGetVoteMainContents(
            limit: limit,
            offset: offset,
            pin: true,
            voteObjId: voteObjId,
          );
          if ((model.data?.pin ?? []).length < limit) isFinalLoadMore = true;
          voteObjId.addAll(model.data?.voteObjId ?? []);
          data.addAll(model.data?.pin ?? []);
          update();
          break;

        case 'ใกล้ปิดโหวต':
          final model = await fetchGetVoteMainContents(
            limit: limit,
            offset: offset,
            closeDate: true,
            voteObjId: voteObjId,
          );
          if ((model.data?.closeDate ?? []).length < limit) isFinalLoadMore = true;
          data.addAll(model.data?.closeDate ?? []);
          update();
          break;

        case 'ใกล้ปิดล่ารายชื่อ':
          final model = await fetchGetVoteMainContents(
            limit: limit,
            offset: offset,
            closetSupport: true,
            voteObjId: voteObjId,
          );
          if ((model.data?.closetSupport ?? []).length < limit) isFinalLoadMore = true;
          data.addAll(model.data?.closetSupport ?? []);
          update();
          break;

        case 'โหวตที่ฉันสร้าง':
          final model = await fetchGetVotemyCreate(
            limit: limit,
            offset: offset,
          );
          if ((model.data?.myVote ?? []).length < limit) isFinalLoadMore = true;
          data.addAll(model.data?.myVote ?? []);
          update();
          break;

        case 'โหวตที่ฉันสร้าง\tและเปิดล่ารายชื่ออยู่':
          final model = await fetchGetVotemyCreate(
            limit: limit,
            offset: offset,
          );
          if ((model.data?.myVoterSupport ?? []).length < limit) isFinalLoadMore = true;
          data.addAll(model.data?.myVoterSupport ?? []);
          update();
          break;

        case 'ที่ฉันเคยโหวต':
          final model = await fetchGetVotemyCreate(
            limit: limit,
            offset: offset,
          );
          if ((model.data?.myVoted ?? []).length < limit) isFinalLoadMore = true;
          data.addAll(model.data?.myVoted ?? []);
          update();
          break;

        case 'ที่ฉันลงชื่อให้การสนับสนุน':
          final model = await fetchGetVotemyCreate(
            limit: limit,
            offset: offset,
          );
          if ((model.data?.mySupported ?? []).length < limit) isFinalLoadMore = true;
          data.addAll(model.data?.mySupported ?? []);
          update();
          break;

        case 'โหวตที่เปิดอยู่':
          final model = await fetchGetVoteOpen(
            limit: limit,
            offset: offset,
          );
          if ((model.data ?? []).length < limit) isFinalLoadMore = true;
          data.addAll(model.data ?? []);
          update();
          break;

        case 'ล่ารายชื่อ':
          final model = await fetchGetVoteSupport(
            limit: limit,
            offset: offset,
          );
          if ((model.data ?? []).length < limit) isFinalLoadMore = true;
          data.addAll(model.data ?? []);
          update();
          break;

        case 'ผลโหวต':
          final model = await fetchGetVoteSupport(
            limit: limit,
            offset: offset,
          );
          if ((model.data ?? []).length < limit) isFinalLoadMore = true;
          data.addAll(model.data ?? []);
          update();
          break;

        /// ในกรณีที่เป็น hashTagVote จะต้องเรียกใช้ fetchGetVoteMainContents ด้วย hashTagVote: true
        default:
          final model = await fetchGetVoteMainContents(
            limit: limit,
            offset: offset,
            hashTagVote: true,
            voteObjId: voteObjId,
          );

          model.data?.hashTagVote?.forEach((element) {
            if (element.id == topic) {
              if ((element.votingEvent ?? []).length < limit) isFinalLoadMore = true;
              data.addAll(element.votingEvent ?? []);
              update();
            }
          });
          break;
      }
    } catch (e) {
      log('', error: e, name: 'fetchGetVote');
    }

    isLoadMoreRunning = false;
    update();

    return;
  }

  Future<VoteMainContentsModel> fetchGetVoteMainContents({
    required int limit,
    required int offset,
    bool pin = false,
    bool myVote = false,
    bool supporter = false,
    bool closeVote = false,
    bool closeDate = false,
    bool closetSupport = false,
    bool hashTagVote = false,
    bool generalSection = false,
    required List<String> voteObjId,
  }) async {
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
        pin: pin,
        myVote: myVote,
        supporter: supporter,
        closeVote: closeVote,
        closeDate: closeDate,
        closetSupport: closetSupport,
        hashTagVote: hashTagVote,
        generalSection: generalSection,
        voteObjId: voteObjId,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VoteMainContentsModel.fromJson(response.body);

      if (model.status == 0) throw Exception(model.message ?? 'Error');

      /// sort closeSupport endSupportDatetime a-z
      model.data?.closetSupport?.sort((a, b) => a.endSupportDatetime!.compareTo(b.endSupportDatetime!));

      /// sort hashTagVote id a-z
      model.data?.hashTagVote?.sort((a, b) => a.id!.compareTo(b.id!));

      return model;
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteMainContents');
      return VoteMainContentsModel();
    }
  }

  Future<VoteMyCreateModel> fetchGetVotemyCreate({int limit = 10, int offset = 0}) async {
    String token = _box.read(StorageKeys.token) ?? '';
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

      return model;
    } catch (e) {
      log('', error: e, name: 'fetchGetVotemyCreate');
      return VoteMyCreateModel();
    }
  }

  Future<VotePostModel> fetchGetVoteOpen({int limit = 10, int offset = 0}) async {
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

      return model;
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteOpen');
      return VotePostModel();
    }
  }

  Future<VotePostModel> fetchGetVoteSupport({int limit = 10, int offset = 0}) async {
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

      return model;
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteSupport');
      return VotePostModel();
    }
  }

  Future<VotePostModel> fetchGetVoteResults({int limit = 10, int offset = 0}) async {
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

      return model;
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteResults');
      return VotePostModel();
    }
  }
}
