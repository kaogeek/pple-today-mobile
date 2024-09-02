import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../component/snack_bar_component.dart';
import '../data/models/comment_list_model.dart';
import '../data/models/comment_list_model.dart' as comment_list;
import '../data/models/delete_comment_model.dart';
import '../data/models/like_comment_model.dart';
import '../data/models/post_search_model.dart';
import '../data/models/profile_user_model.dart';
import '../data/models/story_model.dart';
import '../data/services/today_service.dart';
import '../data/services/user_service.dart';
import '../ui/utils/storage_keys.dart';

class PostDetailController extends GetxController {
  final _serviceUser = UserService();
  final _service = TodayService();

  final _box = GetStorage();

  final String postId = Get.arguments['POST_ID'];
  final bool focus = Get.arguments['FOCUS'] ?? false;

  final FocusNode focusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  final TextEditingController commentTextController = TextEditingController();

  bool isEdit = false;

  String commentId = '';

  @override
  Future<void> onInit() async {
    debugPrint('--> POST_ID: $postId');
    scrollController.addListener(() {});

    isLoading = true;
    update();
    await fetchStory(postId);
    await fetchCommentList(postId);
    await fetchPostSearch(postId);
    isLoading = false;
    if (focus) {
      500.milliseconds.delay(() {
        maxScrollExtent();
      });
    }
    update();
    super.onInit();
  }

  @override
  void onClose() {
    focusNode.dispose();
    scrollController.dispose();
    commentTextController.dispose();
    super.onClose();
  }

  ProfileModel profileUserModel = ProfileModel();
  StoryModel storyModel = StoryModel();
  CommentListModel commentListModel = CommentListModel();
  PostSearchModel postSearchModel = PostSearchModel();
  LikeCommentModel likeCommentModel = LikeCommentModel();
  DeleteCommentModel deleteCommentModel = DeleteCommentModel();

  bool isLoading = false;
  bool isLoadMore = false;
  bool isNotComment = false;

  void maxScrollExtent() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<ProfileModel?> fetchProfileUser() async {
    try {
      String uid = _box.read(StorageKeys.uid) ?? '';

      if (uid.isEmpty) return null;

      Response response = await _serviceUser.getProfileUser(uid);

      profileUserModel = ProfileModel.fromJson(response.body);
      update();

      if (profileUserModel.status == 0) return null;

      return profileUserModel;
    } catch (e) {
      log('', error: e, name: 'FetchProfileUser');
      return null;
    }
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

  Future<void> fetchCommentList(
    String postId, {
    int offset = 0,
    int limit = 5,
  }) async {
    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';

    String? result = await _service.getCommentList(
      postId: postId,
      uid: uid,
      token: token,
      offset: offset,
      limit: limit,
    );

    if (result == null) return;

    final json = jsonDecode(result);
    CommentListModel model = CommentListModel.fromJson(json);

    isNotComment = (model.data ?? []).isEmpty || model.data!.length < 5;

    offset != 0 ? commentListModel.data!.addAll(model.data ?? []) : commentListModel = model;
    update();

    return;
  }

  Future<void> fetchPostSearch(String postId) async {
    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

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

  void addComment() {
    String uid = _box.read(StorageKeys.uid) ?? '';
    String imageURL = _box.read(StorageKeys.imageURL) ?? '';
    String displayName = _box.read(StorageKeys.displayName) ?? '';

    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    math.Random _rnd = math.Random();

    String getRandomID(int length) => String.fromCharCodes(
          Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))),
        );

    comment_list.Data _data = comment_list.Data(
      id: getRandomID(10),
      comment: commentTextController.text,
      createdDate: DateTime.now(),
      user: User(
        id: uid,
        imageUrl: imageURL,
        displayName: displayName,
      ),
    );

    commentListModel.data!.add(_data);

    storyModel.data!.first.commentCount = storyModel.data!.first.commentCount! + 1;
    update();
  }

  Future<String> fetchSendComment({
    required String postId,
    required String comment,
  }) async {
    String mode = _box.read(StorageKeys.mode) ?? '';
    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';

    String? result = await _service.sendComment(
      postId: postId,
      mode: mode,
      uid: uid,
      token: token,
      comment: comment,
    );

    if (result == null) return 'เกินข้อผิดพลาดในการส่ง';

    return '';
  }

  Future<void> fetchIsEditComment({
    required String postId,
    required String commentId,
    required String commentText,
  }) async {
    String mode = _box.read(StorageKeys.mode) ?? '';
    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';

    await _service.isEditComment(
      postId: postId,
      commentId: commentId,
      commentText: commentText,
      uid: uid,
      token: token,
      mode: mode,
    );

    return;
  }

  Future<LikeCommentModel> fetchIsLikeComment({
    required String postId,
    required String commentId,
  }) async {
    try {
      likeCommentModel.clean();

      String mode = _box.read(StorageKeys.mode) ?? '';
      String uid = _box.read(StorageKeys.uid) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';

      Response response = await _service.isLikeComment(
        postId: postId,
        commentId: commentId,
        uid: uid,
        token: token,
        mode: mode,
      );

      if (response.isOk) {
        likeCommentModel = LikeCommentModel.fromJson(response.body);
      } else {
        throw Exception(response.statusText ?? 'เกิดข้อผิดพลาดในการเชื่อมต่อ');
      }
    } catch (e) {
      SnackBarComponent.show(
        title: 'เกิดข้อผิดพลาดในการเชื่อมต่อ',
        type: SnackBarType.error,
      );
      log('', error: e, name: 'FetchIsLikeComment');
    }

    update();
    return likeCommentModel;
  }

  Future<void> fetchDeleteComment({
    required String postId,
    required String commentId,
  }) async {
    String mode = _box.read(StorageKeys.mode) ?? '';
    String uid = _box.read(StorageKeys.uid) ?? '';
    String token = _box.read(StorageKeys.token) ?? '';

    String? result = await _service.isDeleteComment(
      postId: postId,
      commentId: commentId,
      uid: uid,
      token: token,
      mode: mode,
    );

    if (result == null) return;

    final json = jsonDecode(result);
    deleteCommentModel = DeleteCommentModel.fromJson(json);

    update();
    return;
  }
}
