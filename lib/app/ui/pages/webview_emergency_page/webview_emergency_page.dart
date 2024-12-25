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
  WebviewEmergencyPage({super.key});

  @override
  final WebviewEmergencyController controller = Get.put(WebviewEmergencyController());

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: MyAppBar(
        title: controller.title,
        iconImage: controller.iconImage,
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    controller.isProgress.value = progress / 100;
                  },
                  onPageStarted: (String url) {
                    controller.isLoading.value = true;
                  },
                  onPageFinished: (String url) {
                    controller.isLoading.value = false;
                  },
                  onHttpError: (HttpResponseError error) {
                    debugPrint("HttpResponseError : $error", wrapWidth: 1024);
                  },
                  onWebResourceError: (WebResourceError error) {
                    debugPrint("WebResourceError : $error", wrapWidth: 1024);
                  },
                  onNavigationRequest: _navigationDelegate,
                ),
              )
              ..loadRequest(Uri.parse(controller.url)),
          ),
          Obx(() => controller.isLoading.value
              ? LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  value: controller.isProgress.value,
                )
              : SizedBox.shrink()),
        ],
      ),
    );
  }

  NavigationDecision _navigationDelegate(navigation) {
    final String domain = Environment.domainName;
    // debugPrint('_DOMAIN: $_domain');
    final String url = Uri.decodeComponent(navigation.url);
    debugPrint('--- URL: $url');

    bool isPage = url.startsWith('$domain/page/');
    if (isPage) {
      String pageId = url.replaceFirst('$domain/page/', '');
      Get.toNamed(
        AppRoutes.PAGE_PROFILE,
        arguments: {'PAGE_ID': pageId},
      );

      return NavigationDecision.prevent;
    }

    bool isPost = url.startsWith('$domain/post/');
    if (isPost) {
      String postId = url.replaceFirst('$domain/post/', '');
      Get.toNamed(
        AppRoutes.POST_DETAIL,
        arguments: {'POST_ID': postId},
      );

      return NavigationDecision.prevent;
    }

    bool isEmergency = url.startsWith('$domain/emergencyevent/');
    if (isEmergency) {
      // final regExp = RegExp(r'^[a-z0-9]+$');
      // bool split = regExp.hasMatch(emergencyId);
      // debugPrint('SPLIT: $split');

      String realLink = url.replaceAll('?hidebar=true', '');
      String emergencyId = realLink.replaceFirst('$domain/emergencyevent/', '').split('/').first;

      bool isHashTag = url.startsWith('$domain/emergencyevent/$emergencyId/search?hashtag=');
      if (isHashTag) {
        String queryEncode = url.replaceFirst('$domain/emergencyevent/$emergencyId/search?', '').replaceAllMapped(RegExp('[ก-๙]'), (match) {
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

    bool isObjective = url.startsWith('$domain/objective/');
    if (isObjective) {
      String realLink = url.replaceAll('?hidebar=true', '');
      String objectiveId = realLink.replaceFirst('$domain/objective/', '').split('/').first;

      bool isHashTag = url.startsWith('$domain/objective/$objectiveId/search?hashtag=');
      if (isHashTag) {
        String queryEncode = url.replaceFirst('$domain/objective/$objectiveId/search?', '').replaceAllMapped(RegExp('[ก-๙]'), (match) {
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

    bool isSearch = url.startsWith('$domain/search');
    if (isSearch) {
      String realQuery = url.replaceFirst('$domain/search?', '');
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
