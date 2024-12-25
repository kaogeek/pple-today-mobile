import 'dart:convert';

import 'package:get/get.dart';

import 'base_service.dart';

class UserEngagementService extends BaseService {
  Future<Response> postUserEngagement({
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
    Response response = await post(
      '/api/engagement',
      jsonEncode({
        "contentId": contentId,
        "contentType": contentType,
        "ip": ip,
        "device": device,
        "userId": userId,
        "clientId": clientId,
        "isFirst": true,
        "action": "PPLE_NEWS",
        "reference": reference,
        "likeAsPage": likeAsPage,
        "postId": postId,
        "point": point,
        "voteId": voteId,
        "isReadId": isReadId,
        "isRead": true
      }),
    );

    return response;
  }

  Future<Response> isReadLineNoti({
    required String userId,
    required List<String> postId,
    required List<String> votingId,
    required String device,
  }) async {
    Response response = await post(
      '/api/main/is/read',
      jsonEncode({
        'userId': userId,
        'postId': postId,
        'votingId': votingId,
        'isRead': true,
        'device': device,
        'action': 'LINE_NOTI',
      }),
    );

    return response;
  }

  Future<Response> isReadVoteNews({
    required String userId,
    required List<String> postId,
    required List<String> votingId,
    required String device,
  }) async {
    Response response = await post(
      '/api/main/is/read',
      jsonEncode({
        'userId': userId,
        'postId': postId,
        'votingId': votingId,
        'isRead': true,
        'device': device,
        'action': 'PPLE_NEWS',
      }),
    );

    return response;
  }

  Future<Response> isReadVoteEvent({
    required String userId,
    required List<String> postId,
    required List<String> votingId,
    required String device,
  }) async {
    Response response = await post(
      '/api/voting/is/read',
      jsonEncode({
        'userId': userId,
        'postId': postId,
        'votingId': votingId,
        'isRead': true,
        'device': device,
        'action': 'VOTE_EVENT_NOTI',
      }),
    );

    return response;
  }

  Future<Response> updateUserEngage({
    required String engagementId,
    required List<String> voteId,
    required String votingId,
    required List<String> voteItemId,
    required List<String> voteChoiceId,
    required String isReadId,
    required String commentId,
    required String likeId,
  }) async {
    Response response = await patch(
      '/api/engagement/$engagementId',
      jsonEncode({
        if (voteId.isNotEmpty) "voteId": voteId,
        if (votingId.isNotEmpty) "votingId": votingId,
        if (voteItemId.isNotEmpty) "voteItemId": voteItemId,
        if (voteChoiceId.isNotEmpty) "voteChoiceId": voteChoiceId,
        if (isReadId.isNotEmpty) "isReadId": isReadId,
        if (commentId.isNotEmpty) "commentId": commentId,
        if (likeId.isNotEmpty) "likeId": likeId,
      }),
    );

    return response;
  }
}
