import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/hash_tag_id_model.dart';
import '../data/models/hash_tag_post_model.dart';
import '../data/services/search_service.dart';

class HashTagController extends GetxController {
  String hashTag = Get.arguments['HASH_TAG'] ?? '';
  String emerTag = Get.arguments['EMER_TAG'] ?? '';

  final _service = SearchService();

  ScrollController scrollController = ScrollController();

  HashTagIdModel hashTagIdModel = HashTagIdModel();
  HashTagPostModel hashTagPostModel = HashTagPostModel();

  bool isLoadMore = false;
  bool isNotPostStory = false;

  final RxString _emerHashTagId = ''.obs;
  set emerHashTagId(String value) => _emerHashTagId.value = value;
  String get emerHashTagId => _emerHashTagId.value;

  @override
  void onInit() {
    super.onInit();
    debugPrint('HASH_TAG: $hashTag');
    debugPrint('EMER_TAG: $emerTag');
    scrollController.addListener(() => _onLoadMore());
  }

  Future<void> onRefresh() async {
    isNotPostStory = false;
    update();

    await fetchHashTagPost(
      emerTagId: emerHashTagId,
    );
    return;
  }

  Future<void> _onLoadMore() async {
    bool nextPostTrigger = scrollController.position.extentAfter < 1000;

    if (nextPostTrigger && !isLoadMore) {
      if (!isNotPostStory) {
        isLoadMore = true;
        update();

        await fetchHashTagPost(
          emerTagId: emerHashTagId,
          offset: hashTagPostModel.data!.length,
        );

        isLoadMore = false;
        update();
      }
    }
    return;
  }

  void topScrollExtent() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  Future<HashTagIdModel> fetchEmerTagId() async {
    hashTagIdModel.clean();

    try {
      Response response = await _service.getEmerTagId(emerTag: emerTag);

      if (response.isOk) {
        hashTagIdModel = HashTagIdModel.fromJson(response.body);

        emerHashTagId = hashTagIdModel.data!.first.hashTag ?? '';

        await fetchHashTagPost(
          emerTagId: hashTagIdModel.data!.first.hashTag ?? '',
        );
      }
    } catch (e) {
      log('', error: e);
    }

    update();
    return hashTagIdModel;
  }

  Future<HashTagPostModel> fetchHashTagPost({
    String emerTagId = '',
    int limit = 10,
    int offset = 0,
  }) async {
    if (offset == 0) hashTagPostModel.clean();

    try {
      Response response = await _service.getHashTagPost(
        keyword: hashTag,
        emerTag: emerTag,
        emerTagId: emerTagId,
        limit: limit,
        offset: offset,
      );

      if (response.isOk) {
        if (offset == 0) {
          hashTagPostModel = HashTagPostModel.fromJson(response.body);
        } else {
          final _data = HashTagPostModel.fromJson(response.body).data!;

          hashTagPostModel.data!.addAll(_data);
          isNotPostStory = _data.length < limit;
        }
      }
    } catch (e) {
      log('', error: e);
    }

    update();
    return hashTagPostModel;
  }
}
