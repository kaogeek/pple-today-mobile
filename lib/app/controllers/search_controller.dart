import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../data/models/content_search_model.dart';
import '../data/models/history_search_model.dart';
import '../data/models/page_post_search_model.dart';
import '../data/models/search_model.dart';
import '../data/services/search_service.dart';
import '../ui/utils/storage_keys.dart';

class SearchController extends GetxController {
  final _service = SearchService();
  final _box = GetStorage();

  final FocusNode focusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();

  SearchModel searchModel = SearchModel();
  HistorySearchModel historySearchModel = HistorySearchModel();
  ContentSearchModel contentSearchModel = ContentSearchModel();
  PagePostSearchModel pagePostSearchModel = PagePostSearchModel();

  @override
  void onInit() {
    fetchHistorySearch();
    super.onInit();
  }

  Future<void> fetchSearch(String keyword) async {
    searchModel = SearchModel();
    update();

    String uid = _box.read(StorageKeys.uid) ?? '';

    String? result = await _service.getMainSearch(
      keyword: keyword,
      uid: uid,
    );

    if (result == null) {
      searchModel = SearchModel(
        status: 0,
        message: 'Sorry, the network is down.',
      );
      update();

      return;
    }

    final json = jsonDecode(result);
    searchModel = SearchModel.fromJson(json);
    update();

    return;
  }

  Future<void> fetchHistory({
    required String resultType,
    required String resultId,
    required String keyword,
  }) async {
    try {
      String uid = _box.read(StorageKeys.uid) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';

      String? deviceId = await PlatformDeviceId.getDeviceId;

      await _service.postHistory(
        uid: uid,
        deviceId: deviceId!,
        resultType: resultType,
        resultId: resultId,
        keyword: keyword,
        token: token,
      );
    } catch (e) {
      printError(info: e.toString());
    }
    return;
  }

  Future<void> fetchHistorySearch({
    int offset = 0,
    int limit = 10,
    List? relation,
    bool count = false,
    Map? orderBy,
    List<String>? whereConditions,
  }) async {
    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    String? deviceId = await PlatformDeviceId.getDeviceId;

    String? result = await _service.getHistorySearch(
      uid: uid,
      deviceId: deviceId!,
      offset: offset,
      limit: limit,
      relation: relation,
      count: count,
      orderBy: orderBy,
      whereConditions: whereConditions ?? ['PAGE', 'USER'],
      token: token,
      mode: mode,
    );

    if (result == null) {
      historySearchModel = HistorySearchModel(
        status: 0,
        message: 'Sorry, the network is down.',
      );
      update();

      return;
    }

    final json = jsonDecode(result);
    historySearchModel = HistorySearchModel.fromJson(json);
    update();

    return;
  }

  Future<void> fetchContentSearch({
    required List<String> keyword,
    required List<String> hashtag,
    String type = '',
    List? createBy,
    String objective = '',
    List? pageCategories,
    int offset = 0,
    int limit = 5,
  }) async {
    String uid = _box.read(StorageKeys.uid) ?? '';

    String? result = await _service.getContentSearch(
      uid: uid,
      keyword: keyword,
      hashtag: hashtag,
      type: type,
      createBy: createBy,
      objective: objective,
      pageCategories: pageCategories,
      offset: offset,
      limit: limit,
    );

    if (result == null) {
      contentSearchModel = ContentSearchModel(
        status: 0,
        message: 'Sorry, the network is down.',
      );
      update();

      return;
    }

    final json = jsonDecode(result);
    contentSearchModel = ContentSearchModel.fromJson(json);
    update();

    return;
  }
}
