import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/vote_text_model.dart';
import '../data/services/vote_service.dart';
import '../ui/utils/log.dart';
import '../ui/utils/storage_keys.dart';

class MfpVoteAnsweringController extends GetxController {
  final _service = VoteService();
  final _box = GetStorage();

  final String voteId = Get.arguments['VOTE_ID'];
  final String voteImage = Get.arguments['VOTE_IMAGE'] ?? '';
  final String voteTitle = Get.arguments['VOTE_TITLE'];
  final int number = Get.arguments['NUMBER'];
  final bool showVoterName = Get.arguments['SHOW_VOTER_NAME'];

  var voteTextModel = VoteTextModel().obs;

  var isLoadMoreRunning = false.obs;
  var isFinalLoadMore = false.obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    Log.print('voteId: $voteId');

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        fetchApi(offset: voteTextModel().data!.length);
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    fetchApi();
    super.onReady();
  }

  Future<void> fetchApi({
    int offset = 0,
    int limit = 10,
  }) async {
    if (isLoadMoreRunning.value) return;

    if (offset != 0) isLoadMoreRunning.value = true;

    String token = _box.read(StorageKeys.token) ?? '';
    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _service.getVoteText(
        voteId: voteId,
        token: token,
        uid: uid,
        mode: mode,
        offset: offset,
        limit: limit,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VoteTextModel.fromJson(response.body);

      if (model.status == 0) throw Exception(model.message ?? 'Error');

      if ((model.data ?? []).isNotEmpty) {
        model.data!.sort((a, b) => a.createdDate!.compareTo(b.createdDate!));
      }

      if ((model.data ?? []).length < limit) isFinalLoadMore.value = true;

      offset == 0
          ? voteTextModel(model)
          : voteTextModel.update((val) {
              val?.data?.addAll(model.data ?? []);
            });
      voteTextModel.refresh();
    } catch (e) {
      Log.print('fetchApi $e');
    }

    isLoadMoreRunning.value = false;

    return;
  }
}
