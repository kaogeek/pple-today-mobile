
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/services/user_engagement_service.dart';
import '../ui/utils/storage_keys.dart';

class UserEngagementController extends GetxController {
  Future<void> fetchUserEngagement({
    required String contentId,
    required String contentType,
    required String ip,
    required String device,
    required String userId,
    required String clientId,
    required bool isFirst,
    required String action,
    required String reference,
    required String? likeAsPage,
    required String postId,
    required int point,
    required String voteId,
    required String isReadId,
    required bool isRead,
  }) async {
    try {
      final service = Get.put(UserEngagementService());

      Response response = await service.postUserEngagement(
        contentId: contentId,
        contentType: contentType,
        ip: ip,
        device: device,
        userId: userId,
        clientId: clientId,
        isFirst: isFirst,
        action: action,
        reference: reference,
        likeAsPage: likeAsPage,
        postId: postId,
        point: point,
        voteId: voteId,
        isReadId: isReadId,
        isRead: isRead,
      );

      if (response.hasError) throw Exception(response.body);

      // TODO: Handle success

      return;
    } catch (e) {
      debugPrint("Error : $e", wrapWidth: 1024);
    } finally {
      Get.delete<UserEngagementService>();
    }
  }

  Future<void> fetchIsReadLineNoti({
    required List<String> postId,
  }) async {
    try {
      final service = Get.put(UserEngagementService());
      final box = GetStorage();

      Response response = await service.isReadLineNoti(
        userId: box.read(StorageKeys.uid) ?? '',
        postId: postId,
        votingId: [],
        device: 'await DeviceInformation.deviceName,',
      );

      if (response.hasError) throw Exception(response.body);

      // TODO: Handle success

      return;
    } catch (e) {
      debugPrint("Error : $e", wrapWidth: 1024);
    } finally {
      Get.delete<UserEngagementService>();
    }
  }

  Future<void> fetchIsReadVoteNews({
    required List<String> postId,
  }) async {
    try {
      final service = Get.put(UserEngagementService());
      final box = GetStorage();

      Response response = await service.isReadVoteNews(
        userId: box.read(StorageKeys.uid) ?? '',
        postId: postId,
        votingId: [],
        device: 'await DeviceInformation.deviceName',
      );

      if (response.hasError) throw Exception(response.body);

      // TODO: Handle success

      return;
    } catch (e) {
      debugPrint("Error : $e", wrapWidth: 1024);
    } finally {
      Get.delete<UserEngagementService>();
    }
  }

  Future<void> fetchIsReadVoteEvent({
    required List<String> postId,
    required List<String> votingId,
  }) async {
    try {
      final service = Get.put(UserEngagementService());
      final box = GetStorage();

      Response response = await service.isReadVoteEvent(
        userId: box.read(StorageKeys.uid) ?? '',
        postId: postId,
        votingId: votingId,
        device: 'await DeviceInformation.deviceName',
      );

      if (response.hasError) throw Exception(response.body);

      // TODO: Handle success

      return;
    } catch (e) {
      debugPrint("Error : $e", wrapWidth: 1024);
    } finally {
      Get.delete<UserEngagementService>();
    }
  }

  Future<void> fetchUpdateUserEngage({
    required String engagementId,
    required List<String> voteId,
    required String votingId,
    required List<String> voteItemId,
    required List<String> voteChoiceId,
    required String isReadId,
    required String commentId,
    required String likeId,
  }) async {
    try {
      final service = Get.put(UserEngagementService());

      Response response = await service.updateUserEngage(
        engagementId: engagementId,
        voteId: voteId,
        votingId: votingId,
        voteItemId: voteItemId,
        voteChoiceId: voteChoiceId,
        isReadId: isReadId,
        commentId: commentId,
        likeId: likeId,
      );

      if (response.hasError) throw Exception(response.body);

      // TODO: Handle success

      return;
    } catch (e) {
      debugPrint("Error : $e", wrapWidth: 1024);
    } finally {
      Get.delete<UserEngagementService>();
    }
  }
}
