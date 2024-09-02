import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controllers/webview_emergency_controller.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/colors.dart';
import '../../utils/environment.dart';
import 'widgets/my_app_bar.dart';

class WebviewEmergencyPage extends GetView<WebviewEmergencyController> {
  WebviewEmergencyPage({Key? key}) : super(key: key);

  final _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: MyAppBar(
        title: controller.title,
        iconImage: controller.iconImage,
      ),
      body: GetBuilder<WebviewEmergencyController>(
        init: WebviewEmergencyController(),
        initState: (_) {},
        builder: (_) {
          return Stack(
            children: [
              WebView(
                initialUrl: controller.url,
                javascriptMode: JavascriptMode.unrestricted,
                gestureNavigationEnabled: true,
                onPageFinished: (finish) {
                  controller.isLoading = false;
                  controller.update();
                },
                onProgress: (progress) {
                  controller.isProgress = progress / 100;
                  controller.update();
                },
                navigationDelegate: _navigationDelegate,
                onWebViewCreated: (WebViewController webViewController) async {
                  _controller.complete(webViewController);
                },
              ),
              if (controller.isLoading)
                LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    kPrimaryColor,
                  ),
                  value: controller.isProgress,
                ),
            ],
          );
        },
      ),
    );
  }

  NavigationDecision _navigationDelegate(navigation) {
    final String _domain = Environment.domainName;
    // debugPrint('_DOMAIN: $_domain');
    final String _url = Uri.decodeComponent(navigation.url);
    debugPrint('--- URL: $_url');

    bool isPage = _url.startsWith('$_domain/page/');
    if (isPage) {
      String pageId = _url.replaceFirst('$_domain/page/', '');
      Get.toNamed(
        AppRoutes.PAGE_PROFILE,
        arguments: {'PAGE_ID': pageId},
      );

      return NavigationDecision.prevent;
    }

    bool isPost = _url.startsWith('$_domain/post/');
    if (isPost) {
      String postId = _url.replaceFirst('$_domain/post/', '');
      Get.toNamed(
        AppRoutes.POST_DETAIL,
        arguments: {'POST_ID': postId},
      );

      return NavigationDecision.prevent;
    }

    bool isEmergency = _url.startsWith('$_domain/emergencyevent/');
    if (isEmergency) {
      // final regExp = RegExp(r'^[a-z0-9]+$');
      // bool split = regExp.hasMatch(emergencyId);
      // debugPrint('SPLIT: $split');

      String realLink = _url.replaceAll('?hidebar=true', '');
      String emergencyId = realLink.replaceFirst('$_domain/emergencyevent/', '').split('/').first;

      bool isHashTag = _url.startsWith('$_domain/emergencyevent/$emergencyId/search?hashtag=');
      if (isHashTag) {
        String queryEncode = _url
            .replaceFirst('$_domain/emergencyevent/$emergencyId/search?', '')
            .replaceAllMapped(RegExp('[ก-๙]'), (match) {
          return Uri.encodeComponent('${match.group(0)}');
        });

        Map queryMap = Uri.splitQueryString(queryEncode);

        Get.toNamed(
          AppRoutes.HASH_TAG,
          arguments: {
            'HASH_TAG': queryMap['hashtag'],
            'EMER_TAG': queryMap['emertag'],
          },
        );
        return NavigationDecision.prevent;
      }
    }

    bool isObjective = _url.startsWith('$_domain/objective/');
    if (isObjective) {
      String realLink = _url.replaceAll('?hidebar=true', '');
      String objectiveId = realLink.replaceFirst('$_domain/objective/', '').split('/').first;

      bool isHashTag = _url.startsWith('$_domain/objective/$objectiveId/search?hashtag=');
      if (isHashTag) {
        String queryEncode =
            _url.replaceFirst('$_domain/objective/$objectiveId/search?', '').replaceAllMapped(RegExp('[ก-๙]'), (match) {
          return Uri.encodeComponent('${match.group(0)}');
        });

        Map queryMap = Uri.splitQueryString(queryEncode);

        Get.toNamed(
          AppRoutes.HASH_TAG,
          arguments: {
            'HASH_TAG': queryMap['hashtag'],
            'EMER_TAG': queryMap['emertag'],
          },
        );
        return NavigationDecision.prevent;
      }
    }

    bool isSearch = _url.startsWith('$_domain/search');
    if (isSearch) {
      String realQuery = _url.replaceFirst('$_domain/search?', '');
      String params = realQuery.split('=').first;

      switch (params) {
        case 'hashtag':
          String hashTag = realQuery.split('=')[1];
          Get.toNamed(
            AppRoutes.HASH_TAG,
            arguments: {'KEYWORD': hashTag},
          );
          return NavigationDecision.prevent;

        default:
          return NavigationDecision.navigate;
      }
    }

    return NavigationDecision.navigate;
  }
}
