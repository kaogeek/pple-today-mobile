import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../component/loading.dart';
import '../data/models/vote_post_model.dart';
import '../data/services/vote_service.dart';
import '../ui/utils/storage_keys.dart';

class MfpVoteSeachController extends GetxController {
  final _service = VoteService();
  final _box = GetStorage();

  var scrollController = ScrollController().obs;
  var textController = TextEditingController().obs;
  var focusNode = FocusNode().obs;

  var searchVoteModel = VotePostModel().obs;
  var indexTab = 0.obs;

  @override
  void onInit() {
    textController.value.text = '';

    /// Load more data when scroll to end
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent) {
        fetchGetVoteAll(
          textController.value.text,
          limit: 10,
          offset: searchVoteModel.value.data?.length ?? 0,
        );
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    focusNode.value.requestFocus();
    super.onReady();
  }

  @override
  void onClose() {
    textController.value.dispose();
    focusNode.value.dispose();
    super.onClose();
  }

  Future<void> onSelectedTab(int index) async {
    indexTab.value = index;
    searchVoteModel.value.data?.clear();

    if (textController.value.text.isEmpty) return;

    Loading.show();
    switch (index) {
      case 0:
        await fetchGetVoteAll(textController.value.text);
        break;

      case 1:
        await fetchGetVoteOpen(textController.value.text);
        break;

      case 2:
        await fetchGetVoteSupport(textController.value.text);
        break;

      case 3:
        await fetchGetVoteResults(textController.value.text);
        break;
    }
    Loading.dismiss();
  }

  Future<void> fetchGetVoteAll(
    String keyword, {
    int limit = 10,
    int offset = 0,
  }) async {
    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _service.getVoteSearch(
        uid: uid,
        token: token,
        mode: mode,
        keyword: keyword,
        limit: limit,
        offset: offset,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VotePostModel.fromJson(response.body);

      if (model.status == 0) throw Exception(model.message ?? 'Error');

      if ((model.data ?? []).isNotEmpty) {
        // TODO: data.length < limit

        offset == 0
            ? searchVoteModel(model)
            : searchVoteModel.update((val) {
                val?.data?.addAll(model.data ?? []);
              });
      } else {
        // TODO: No data
      }
    } catch (e) {
      log('', error: e, name: 'FetchGetVoteAll');
      // TODO catch error
    }

    searchVoteModel.refresh();
    return;
  }

  Future<void> fetchGetVoteOpen(
    String keyword, {
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
        keyword: keyword,
        limit: limit,
        offset: offset,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VotePostModel.fromJson(response.body);

      if (model.status == 0) throw Exception(model.message ?? 'Error');

      if ((model.data ?? []).isNotEmpty) {
        model.data!.sort((a, b) => a.endVoteDatetime!.compareTo(b.endVoteDatetime!));

        // TODO: data.length < limit

        offset == 0
            ? searchVoteModel(model)
            : searchVoteModel.update((val) {
                val?.data?.addAll(model.data ?? []);
              });
      } else {
        // TODO: No data
      }
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteOpen');
      // TODO catch error
    }

    searchVoteModel.refresh();
    return;
  }

  Future<void> fetchGetVoteSupport(
    String keyword, {
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
        keyword: keyword,
        limit: limit,
        offset: offset,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VotePostModel.fromJson(response.body);

      if (model.status == 0) throw Exception(model.message ?? 'Error');

      if ((model.data ?? []).isNotEmpty) {
        model.data!.sort((a, b) => a.endVoteDatetime!.compareTo(b.endVoteDatetime!));

        // TODO: data.length < limit

        offset == 0
            ? searchVoteModel(model)
            : searchVoteModel.update((val) {
                val?.data?.addAll(model.data ?? []);
              });
      } else {
        // TODO: No data
      }
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteSupport');
      // TODO catch error
    }

    searchVoteModel.refresh();
    return;
  }

  Future<void> fetchGetVoteResults(
    String keyword, {
    int limit = 10,
    int offset = 0,
  }) async {
    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _service.getVoteResults(
        uid: uid,
        token: token,
        mode: mode,
        keyword: keyword,
        limit: limit,
        offset: offset,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VotePostModel.fromJson(response.body);

      if (model.status == 0) throw Exception(model.message ?? 'Error');

      if ((model.data ?? []).isNotEmpty) {
        model.data!.sort((a, b) => a.endVoteDatetime!.compareTo(b.endVoteDatetime!));

        // TODO: data.length < limit

        offset == 0
            ? searchVoteModel(model)
            : searchVoteModel.update((val) {
                val?.data?.addAll(model.data ?? []);
              });
      } else {
        // TODO: No data
      }
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteResults');
      // TODO catch error
    }

    searchVoteModel.refresh();
    return;
  }
}
