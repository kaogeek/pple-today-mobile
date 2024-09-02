import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/page_model.dart';
import '../data/models/page_post_search_model.dart';
import '../data/services/page_service.dart';
import '../ui/utils/storage_keys.dart';

class PageProfileController extends GetxController {
  final _service = PageService();
  final _box = GetStorage();

  final String pageId = Get.arguments['PAGE_ID'];

  final ScrollController scrollController = ScrollController();

  @override
  Future<void> onInit() async {
    debugPrint('--> PAGE_ID: $pageId');
    scrollController.addListener(() {
      position = scrollController.position.pixels;
      update();

      _onLoadMore();
    });

    isLoading = true;
    update();

    await fetchPage(pageId);
    await fetchPagePostSearch(pageId);

    isLoading = false;
    update();
    super.onInit();
  }

  PageModel pageModel = PageModel();
  PagePostSearchModel pagePostSearchModel = PagePostSearchModel();

  // String pageId = '';
  bool isLoading = true;
  bool isLoadMore = false;
  bool isNoMore = false;

  int offset = 0;

  double position = 0.0;

  Future<void> onRefresh() async {
    offset = 0;
    update();

    await fetchPage(pageId);
    await fetchPagePostSearch(pageId);

    return;
  }

  Future<void> _onLoadMore() async {
    if (isNoMore) return;

    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
      isLoadMore = true;
      update();

      _maxScrollExtent();
      offset += 10;
      update();

      await fetchPagePostSearch(
        pageId,
        offset: offset,
      );

      isLoadMore = false;
      update();
    }
  }

  void topScrollExtent() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  void _maxScrollExtent() {
    100.milliseconds.delay(() {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent - 10,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    });
  }

  Future<PageModel?> fetchPage(
    String pageId,
    // {bool onRef = false,}
  ) async {
    // if (!onRef) {
    //   pageModel = PageModel();
    // }

    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    String? result = await _service.getPage(
      pageId: pageId,
      uid: uid,
      mode: mode,
    );

    if (result == null) {
      pageModel = PageModel(
        status: 0,
        message: 'Sorry, the network is down.',
      );
      return null;
    }

    final json = jsonDecode(result);
    pageModel = PageModel.fromJson(json);

    update();
    return pageModel;
  }

  Future<PagePostSearchModel?> fetchPagePostSearch(
    String pageId, {
    String type = '',
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      String uid = _box.read(StorageKeys.uid) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      Response response = await _service.getPagePostSearch(
        pageId: pageId,
        type: type,
        offset: offset,
        limit: limit,
        uid: uid,
        mode: mode,
      );

      if (response.hasError) {
        throw Exception(response.statusText ?? 'Error');
      }

      if (response.body['data'].isNotEmpty) {
        final model = PagePostSearchModel.fromJson(response.body);

        offset != 0
            ? {
                pagePostSearchModel.data!.posts!.addAll(model.data?.posts ?? []),
                pagePostSearchModel.message = model.message ?? 'Page Post Not Found',
                if ((model.data?.posts ?? []).isEmpty) isNoMore = true,
              }
            : pagePostSearchModel = model;
      } else {
        isNoMore = true;
      }
    } catch (e) {
      log('', error: e, name: 'FetchPagePostSearch');
    }

    update();
    return pagePostSearchModel;
  }

  Future<void> fetchUpdatePage({
    required String pageId,
    String? pageName,
    String? pageUsername,
    String? backgroundStory,
    String? lineId,
    String? facebookURL,
    String? twitterURL,
    String? websiteURL,
    String? email,
  }) async {
    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';

    await _service.updatePage(
      pageId: pageId,
      token: token,
      uid: uid,
      mode: mode,
      pageName: pageName,
      pageUsername: pageUsername,
      backgroundStory: backgroundStory,
      lineId: lineId,
      facebookURL: facebookURL,
      twitterURL: twitterURL,
      websiteURL: websiteURL,
      email: email,
    );

    return;
  }
}
