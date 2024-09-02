import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../component/snack_bar_component.dart';
import '../data/models/announcement_model.dart';
import '../data/models/comment_list_model.dart';
import '../data/models/content_model.dart' as content;
import '../data/models/followed_page_model.dart';
import '../data/models/post_search_model.dart';
import '../data/models/post_story_model.dart';
import '../data/models/profile_uid_model.dart';
import '../data/models/recommend_user_model.dart';
import '../data/models/story_model.dart';
import '../data/services/today_service.dart';
import '../ui/utils/storage_keys.dart';

class TodayController extends GetxController {
  final _service = TodayService();
  final _box = GetStorage();

  Timer? timerLike;

  @override
  Future<void> onInit() async {
    fetchMergencyEvents();

    isLoading = true;
    update();

    await fetchAnnouncement();
    await fetchRecommendedUserPage();
    await fetchPostStory();

    isLoading = false;
    update();
    super.onInit();
  }

  content.ContentModel contentModel = content.ContentModel();
  PostStoryModel postStoryModel = PostStoryModel();
  ProfileUidModel profileUidModel = ProfileUidModel();
  StoryModel storyModel = StoryModel();
  CommentListModel commentListModel = CommentListModel();
  PostSearchModel postSearchModel = PostSearchModel();
  RecommendUserModel recommendUserModel = RecommendUserModel();
  FollowedModel followedModel = FollowedModel();
  AnnouncementModel announcementModel = AnnouncementModel();

  int offsetStory = 0;
  int sublistIndex = 0;

  bool isLoading = true;
  bool isNotPostStory = false;
  bool isNotComment = false;
  bool isRefresh = false;

  Future<void> fetchAnnouncement() async {
    try {
      final result1 = await _fetchAnnouncementEnable();
      final result2 = await _fetchAnnouncementText();
      final result3 = await _fetchAnnouncementLink();

      announcementModel.clear();

      announcementModel.data?.offOn = result1.data!.offOn!;
      announcementModel.data?.value = result2.data!.value!;
      announcementModel.data?.link = result3.data!.link!;
    } on Exception catch (e) {
      announcementModel.clear();
      log('', error: e, name: 'fetchAnnouncement');
    }

    update();
    return;
  }

  Future<AnnouncementModel> _fetchAnnouncementEnable() async {
    Response response = await _service.getAnnouncementEnable();

    return AnnouncementModel.fromJson(response.body);
  }

  Future<AnnouncementModel> _fetchAnnouncementText() async {
    Response response = await _service.getAnnouncementText();

    return AnnouncementModel.fromJson(response.body);
  }

  Future<AnnouncementModel> _fetchAnnouncementLink() async {
    Response response = await _service.getAnnouncementLink();

    return AnnouncementModel.fromJson(response.body);
  }

  Future<void> fetchMergencyEvents() async {
    contentModel.clear();

    try {
      Response response = await _service.getMainContent();

      contentModel = content.ContentModel.fromJson(response.body);
    } catch (e) {
      log('', error: e, name: 'fetchMergencyEvents');
      contentModel = content.ContentModel(
        status: 0,
        message: 'ขออภัย เกิดข้อผิดพลาดในการเชื่อมต่อระบบ',
        data: content.Data(
          emergencyEvents: content.EmergencyEvents(contents: []),
          emergencyPin: content.EmergencyPin(contents: []),
          postSectionModel: content.PostSectionModel(contents: []),
          pageRoundRobin: content.PageRoundRobin(contents: []),
          objectiveEvents: content.ObjectiveEvents(contents: []),
        ),
      );
    }

    update();
    return;
  }

  Future<void> fetchPostStory({
    int offset = 0,
    int limit = 10,
  }) async {
    String uid = _box.read(StorageKeys.uid) ?? '';
    List<String> _listBlockUser = _box.read(StorageKeys.blockUser) ?? [];

    try {
      String? result = await _service.getPostStory(
        offset: offset,
        uid: uid,
        limit: limit,
      );

      if (result == null) return;

      final json = jsonDecode(result);
      PostStoryModel model = PostStoryModel.fromJson(json);

      // model.data!.removeWhere((element) => (element.page?.isOfficial ?? false) == false || element.post?.pageId == null);

      isNotPostStory = (model.data ?? []).isEmpty || model.data!.length < limit;

      // *UGC
      final _resultModel = model.data!.where((element) => !_listBlockUser.contains(element.post?.page?.id ?? element.post?.pageId ?? '')).toList();

      model.data = _resultModel;

      offset != 0 ? postStoryModel.data!.addAll(model.data ?? []) : postStoryModel = model;

      if (!isNotPostStory && postStoryModel.data!.length < 10) {
        offsetStory += limit;
        await fetchPostStory(offset: offsetStory);
      }
    } catch (e) {
      printError(info: e.toString());
    }

    update();
    return;
  }

  Future<StoryModel?> fetchStory(String postId) async {
    String uid = _box.read(StorageKeys.uid) ?? '';

    String? result = await _service.getStory(
      postId: postId,
      uid: uid,
    );

    if (result == null) return null;

    final json = jsonDecode(result);
    storyModel = StoryModel.fromJson(json);

    update();
    return storyModel;
  }

  Future<void> fetchPostSearch(String postId) async {
    String mode = _box.read(StorageKeys.mode) ?? '';
    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';

    String? result = await _service.postSearch(
      postId: postId,
      mode: mode,
      uid: uid,
      token: token,
    );

    if (result == null) return;

    final json = jsonDecode(result);
    postSearchModel = PostSearchModel.fromJson(json);

    update();
    return;
  }

  Future<bool> fetchIsLike(String postId) async {
    timerLike = Timer(const Duration(seconds: 1), () {
      timerLike!.cancel();
    });

    try {
      String mode = _box.read(StorageKeys.mode) ?? '';
      String uid = _box.read(StorageKeys.uid) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';

      Response response = await _service.isLike(
        postId: postId,
        uid: uid,
        token: token,
        mode: mode,
      );

      if (response.hasError) {
        throw Exception(response.statusText ?? 'เกิดข้อผิดพลาดในการเชื่อมต่อ');
      }
    } catch (e) {
      SnackBarComponent.show(
        title: 'เกิดข้อผิดพลาดในการเชื่อมต่อ',
        type: SnackBarType.error,
      );
      log('', error: e, name: 'FetchIsLike');
      return false;
    }

    return true;
  }

  Future<void> fetchRecommendedUserPage({
    int offset = 0,
    int limit = 5,
  }) async {
    try {
      String mode = _box.read(StorageKeys.mode) ?? '';
      String uid = _box.read(StorageKeys.uid) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';

      Response response = await _service.getRecommendedUserPage(
        offset: offset,
        limit: limit,
        token: token,
        uid: uid,
        mode: mode,
      );

      recommendUserModel = RecommendUserModel.fromJson(response.body);
    } catch (e) {
      log('', error: e, name: 'FetchRecommendedUserPage');
    }

    update();
    return;
  }

  Future<FollowedModel> fetchFollowed({
    required String pageId,
    required String type,
  }) async {
    try {
      followedModel.clear();

      String mode = _box.read(StorageKeys.mode) ?? '';
      String uid = _box.read(StorageKeys.uid) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';
      String? tokenFCM = _box.read(StorageKeys.tokenFCM);

      Response response = await _service.follow(
        pageId: pageId,
        type: type.toUpperCase(),
        token: token,
        uid: uid,
        mode: mode,
        tokenFCM: tokenFCM,
      );

      followedModel = FollowedModel.fromJson(response.body);
    } catch (e) {
      followedModel = FollowedModel(
        status: 0,
        message: 'ขออภัย เกิดข้อผิดพลาดในการเชื่อมต่อระบบ',
      );
    }

    update();
    return followedModel;
  }
}
