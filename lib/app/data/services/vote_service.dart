import 'dart:convert';

import 'package:get/get.dart';

import '../../ui/utils/environment.dart';
import '../../ui/utils/log.dart';
import '../models/create_item_model.dart';
import '../models/edit_vote_item_model.dart';
import '../models/voting_model.dart';

class VoteService extends GetConnect {
  Future<Response> supportVote({
    required String voteId,
    required String token,
    required String uid,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/voting/support/$voteId';

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      null,
      headers: headers,
    );

    return response;
  }

  Future<Response> unSupportVote({
    required String voteId,
    required String token,
    required String uid,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/voting/unsupport';

    String body = jsonEncode({
      "votingId": voteId,
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getUserSupportVote({
    required String voteId,
    required String token,
    required String uid,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/voting/get/support/$voteId';

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await get(
      url,
      headers: headers,
    );

    return response;
  }

  Future<Response> createVoteAsPage({
    required String token,
    required String uid,
    required String mode,
    required String pageId,
    required CreateItemModel createItemModel,
  }) async {
    String url = '${Environment.apiURL}/api/voting/$pageId/page';

    String body = jsonEncode(createItemModel.toJson());
    Log.print('body: $body');

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
    // return const Response(statusCode: 400);
  }

  Future<Response> createVoteAsUser({
    required String token,
    required String uid,
    required String mode,
    required CreateItemModel createItemModel,
  }) async {
    String url = '${Environment.apiURL}/api/voting/own';

    String body = jsonEncode(createItemModel.toJson());
    Log.print('body: $body');

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
    // return const Response(statusCode: 400);
  }

  Future<Response> getVoteHashTagList() async {
    String url = '${Environment.apiURL}/api/admin/voted/hashtag';

    Response response = await get(url);

    return response;
  }

  Future<Response> getVoteSearch({
    required String token,
    required String uid,
    required String mode,
    required String keyword,
    required int limit,
    required int offset,
  }) async {
    String url = '${Environment.apiURL}/api/voting/vote/search';

    String body = jsonEncode({
      'filter': {
        'limit': limit,
        'offset': offset,
      },
      "whereConditions": {},
      'keyword': keyword,
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getVoteMainContents({
    required String token,
    required String uid,
    required String mode,
    required int limit,
    required int offset,
    required bool pin,
    required bool myVote,
    required bool supporter,
    required bool closeVote,
    required bool closeDate,
    required bool closetSupport,
    required bool hashTagVote,
    required bool generalSection,
    required List<String> voteObjId,
  }) async {
    String url = '${Environment.apiURL}/api/voting/contents';

    String body = jsonEncode({
      "limit": limit,
      "offset": offset,
      "keyword": "",
      if (pin) "pin": true,
      // if(myVote) "myVote": token.isNotEmpty ? true : false,
      if (supporter) "supporter": true,
      if (closeVote) "closeVote": true,
      if (closeDate) "closeDate": true,
      if (closetSupport) "closetSupport": true,
      if (hashTagVote) "hashTagVote": true,
      if (generalSection) "generalSection": true,
      "voteObjId": voteObjId,
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getVoteMyCreate({
    required String token,
    required String uid,
    required String mode,
    required int limit,
    required int offset,
  }) async {
    String url = '${Environment.apiURL}/api/voting/own/search';

    String body = jsonEncode({
      "limit": limit,
      "offset": offset,
      "myVote": true,
      "myVoterSupport": true,
      "myVoted": true,
      "mySupported": true,
      "keyword": "",
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getVotePin({
    required String token,
    required String uid,
    required String mode,
    required String keyword,
    required int limit,
    required int offset,
  }) async {
    String url = '${Environment.apiURL}/api/voting/vote/search';

    String body = jsonEncode({
      'filter': {
        'limit': limit,
        'offset': offset,
      },
      'whereConditions': {
        'approved': true,
        'pin': true,
      },
      'keyword': keyword,
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getVoteMy({
    required String token,
    required String uid,
    required String mode,
    required int limit,
    required int offset,
  }) async {
    String url = '${Environment.apiURL}/api/voting/own/search';

    String body = jsonEncode({
      'filter': {
        'limit': limit,
        'offset': offset,
      },
      'whereConditions': {},
      'keyword': '',
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getVoteOpen({
    required String token,
    required String uid,
    required String mode,
    required String keyword,
    required int limit,
    required int offset,
  }) async {
    String url = '${Environment.apiURL}/api/voting/vote/search';

    String body = jsonEncode({
      'filter': {
        'limit': limit,
        'offset': offset,
      },
      'whereConditions': {
        'approved': true,
        'closed': false,
        'status': 'vote',
      },
      'keyword': keyword
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getVoteSupport({
    required String token,
    required String uid,
    required String mode,
    required String keyword,
    required int limit,
    required int offset,
  }) async {
    String url = '${Environment.apiURL}/api/voting/vote/search';

    String body = jsonEncode({
      'filter': {
        'limit': limit,
        'offset': offset,
      },
      'whereConditions': {'status': 'support'},
      'keyword': keyword,
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getVoteResults({
    required String token,
    required String uid,
    required String mode,
    required String keyword,
    required int limit,
    required int offset,
  }) async {
    String url = '${Environment.apiURL}/api/voting/vote/search';

    String body = jsonEncode({
      'filter': {
        'limit': limit,
        'offset': offset,
      },
      'whereConditions': {
        // 'approved': true,
        // 'status': 'vote',
        'closed': true,
      },
      'keyword': keyword,
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> postSendVotePoint({
    required String voteId,
    required String token,
    required String uid,
    required String mode,
    required VotingModel votingModel,
  }) async {
    String url = '${Environment.apiURL}/api/voting/voted/$voteId';

    String body = jsonEncode(votingModel.toJson());

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    print('BODY: $body');

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getVoteText({
    required String voteId,
    required String token,
    required String uid,
    required String mode,
    required int offset,
    required int limit,
  }) async {
    String url = '${Environment.apiURL}/api/voting/user/vote/text/$voteId';

    String body = jsonEncode({
      "filter": {
        "offset": offset,
        "limit": limit,
      },
      "whereConditions": {
        "voteChoice": null,
      }
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getVotingOwn({
    required String voteId,
    required String token,
    required String uid,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/voting/voted/own/$voteId';

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await get(
      url,
      headers: headers,
    );

    return response;
  }

  Future<Response> getVoting({
    required String voteId,
    required String token,
    required String uid,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/voting/item/vote/$voteId';

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await get(
      url,
      headers: headers,
    );

    return response;
  }

  Future<Response> getVoteDetail({
    required String voteId,
    required String token,
    required String uid,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/voting/$voteId';

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await get(
      url,
      headers: headers,
    );

    return response;
  }

  Future<Response> editVoting({
    required String voteId,
    required String token,
    required String uid,
    required String mode,
    required EditVoteItemModel editVoteItemModel,
  }) async {
    String url = '${Environment.apiURL}/api/voting/own/$voteId';

    String body = jsonEncode(editVoteItemModel.toJson());
    Log.print('body: $body');

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await put(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> deleteVoting({
    required String voteId,
    required String token,
    required String uid,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/voting/own/$voteId';

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await delete(
      url,
      headers: headers,
    );

    return response;
  }
}
