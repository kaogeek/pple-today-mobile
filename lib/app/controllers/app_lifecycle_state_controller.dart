// ignore_for_file: library_prefixes

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_links/uni_links.dart' as UniLink;

import '../routes/app_routes.dart';
import '../ui/utils/storage_keys.dart';
import 'mfp_vote_dashboard_controller.dart';

class AppLifecycleStateController extends GetxController with WidgetsBindingObserver {
  final DateTime _dateNow = DateTime.now();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    debugPrint('STATE: $state', wrapWidth: 1024);
    switch (state) {
      /// App is resumed
      case AppLifecycleState.resumed:
        0.5.seconds.delay(() => fetchFirebaseOpenedApp().then((value) {
              if (!value) {
                final link = GetStorage().read(StorageKeys.initLink);
                link == null ? initUniLinks() : streamUniLinks();
              }
            }));
        break;

      /// App is inactive
      case AppLifecycleState.inactive:
        break;

      /// App is paused
      case AppLifecycleState.paused:
        break;

      /// App is detached
      case AppLifecycleState.detached:
        break;

      /// App is default
      default:
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    /* 2.5.seconds.delay(() => _fetchFirebaseOpenedApp().then((value) {
          if (!value) _initUniLinks();
        })); */
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<bool> fetchFirebaseOpenedApp() async {
    try {
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();

      if (remoteMessage != null) {
        String link = remoteMessage.data['link'].toString();
        String type = remoteMessage.data['notificationType'].toString().toUpperCase();

        _navigationToPage(
          type: type,
          link: link,
        );

        return true;
      }
    } catch (e) {
      log('', error: e, name: 'FIREBASE');
      return false;
    }

    return false;
  }

  Future<void> initUniLinks() async {
    debugPrint('_INITUNILINKS');

    try {
      final String? link = await UniLink.getInitialLink();
      debugPrint('LINK: $link');

      if (link != null) {
        String path = link.replaceFirst('https://today.pplethai.org/', '');

        late String type;
        type = path.split('/').first.toUpperCase();
        if (type.contains('HOME')) type = 'HOME';
        debugPrint('INIT_UNI_LINKS_TYPE: $type', wrapWidth: 1024);

        await GetStorage().write(StorageKeys.initLink, link);

        _navigationToPage(
          type: type,
          link: link,
        );
      }
    } catch (e) {
      log('', error: e, name: 'UNILINKS');
      // Handle exception by warning the user their action did not succeed
      // return
    }
  }

  Future<void> streamUniLinks() async {
    debugPrint('_STREAMUNILINKS');

    try {
      final String? link = await UniLink.linkStream.first;
      debugPrint('LINK: $link');

      if (link != null) {
        String path = link.replaceFirst('https://today.pplethai.org/', '');

        late String type;
        type = path.split('/').first.toUpperCase();
        if (type.startsWith('HOME?')) type = 'HOME';
        debugPrint('STREAM_UNI_LINKS_TYPE: $type', wrapWidth: 1024);

        _navigationToPage(
          type: type,
          link: link,
        );
      }
    } catch (e) {
      log('', error: e, name: 'UNILINKS');
      // Handle exception by warning the user their action did not succeed
      // return
    }
  }

  Future<void> _navigationToPage({required String type, required String link}) async {
    switch (type) {
      /// App Link
      case 'PAGE':
        Get.toNamed(
          AppRoutes.PAGE_PROFILE,
          arguments: {'PAGE_ID': link.split('/').last},
        );
        break;

      case 'USER':
        // TODO: Handle this case.

        break;

      case 'POST':
        Get.toNamed(
          AppRoutes.POST_DETAIL,
          arguments: {'POST_ID': link.split('/').last},
        );
        break;

      case 'SEARCH':
        // TODO: Handle this case.

        break;

      case 'EMERGENCYEVENT':
        Get.toNamed(
          AppRoutes.WEBVIEW_EMERGENCY,
          arguments: {
            'URL': link,
            'TITLE': '',
            'ICON_IMAGE': '',
          },
        );
        break;

      case 'OBJECTIVE':
        Get.toNamed(
          AppRoutes.WEBVIEW_EMERGENCY,
          arguments: {
            'URL': link,
            'TITLE': '',
            'ICON_IMAGE': '',
          },
        );
        break;

      /// RemoteMessage NotificationType
      case 'TODAY_NEWS':
        Uri _uri = Uri.parse(link);
        String date = _uri.queryParameters['date'] ?? '';

        /// check date format is ##-##-#### to ####-##-##
        final RegExp regex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
        if (date.isNotEmpty && regex.hasMatch(date)) {
          List<String> _date = date.split('-');
          date = '${_date[2]}-${_date[1]}-${_date[0]}';

          Get.toNamed(
            AppRoutes.DETAIL_FIRST,
            arguments: {
              'TIME_STAMP': date,
            },
          );
          return;
        }

        /// check date format is ##/##/#### to ####-##-##
        final RegExp regex2 = RegExp(r'^\d{2}/\d{2}/\d{4}$');
        if (date.isNotEmpty && regex2.hasMatch(date)) {
          List<String> _date = date.split('/');
          date = '${_date[2]}-${_date[1]}-${_date[0]}';

          Get.toNamed(
            AppRoutes.DETAIL_FIRST,
            arguments: {
              'TIME_STAMP': date,
            },
          );
          return;
        }

        /// check date format is ####-##-## to ####-##-##
        final RegExp regex3 = RegExp(r'^\d{4}-\d{2}-\d{2}$');
        if (date.isNotEmpty && regex3.hasMatch(date)) {
          Get.toNamed(
            AppRoutes.DETAIL_FIRST,
            arguments: {
              'TIME_STAMP': date,
            },
          );
          return;
        }

        /// check date format is ####/##/## to ####-##-##
        final RegExp regex4 = RegExp(r'^\d{4}/\d{2}/\d{2}$');
        if (date.isNotEmpty && regex4.hasMatch(date)) {
          List<String> _date = date.split('/');
          date = '${_date[0]}-${_date[1]}-${_date[2]}';

          Get.toNamed(
            AppRoutes.DETAIL_FIRST,
            arguments: {
              'TIME_STAMP': date,
            },
          );
          return;
        }
        break;

      case 'HOME':
        Uri _uri = Uri.parse(link);
        String date = _uri.queryParameters['date'] ?? '';

        /// check date format is ##-##-#### to ####-##-##
        final RegExp regex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
        if (date.isNotEmpty && regex.hasMatch(date)) {
          List<String> _date = date.split('-');
          date = '${_date[2]}-${_date[1]}-${_date[0]}';

          Get.toNamed(
            AppRoutes.DETAIL_FIRST,
            arguments: {
              'TIME_STAMP': date,
            },
          );
          return;
        }

        /// check date format is ##/##/#### to ####-##-##
        final RegExp regex2 = RegExp(r'^\d{2}/\d{2}/\d{4}$');
        if (date.isNotEmpty && regex2.hasMatch(date)) {
          List<String> _date = date.split('/');
          date = '${_date[2]}-${_date[1]}-${_date[0]}';

          Get.toNamed(
            AppRoutes.DETAIL_FIRST,
            arguments: {
              'TIME_STAMP': date,
            },
          );
          return;
        }

        /// check date format is ####-##-## to ####-##-##
        final RegExp regex3 = RegExp(r'^\d{4}-\d{2}-\d{2}$');
        if (date.isNotEmpty && regex3.hasMatch(date)) {
          Get.toNamed(
            AppRoutes.DETAIL_FIRST,
            arguments: {
              'TIME_STAMP': date,
            },
          );
          return;
        }

        /// check date format is ####/##/## to ####-##-##
        final RegExp regex4 = RegExp(r'^\d{4}/\d{2}/\d{2}$');
        if (date.isNotEmpty && regex4.hasMatch(date)) {
          List<String> _date = date.split('/');
          date = '${_date[0]}-${_date[1]}-${_date[2]}';

          Get.toNamed(
            AppRoutes.DETAIL_FIRST,
            arguments: {
              'TIME_STAMP': date,
            },
          );
          return;
        }

        break;

      case 'FOLLOW':
        Get.toNamed(
          AppRoutes.PAGE_PROFILE,
          arguments: {'PAGE_ID': link.split('/').last},
        );
        break;

      case 'COMMENT':
        Get.toNamed(
          AppRoutes.POST_DETAIL,
          arguments: {'POST_ID': link.split('/').last},
        );
        break;

      case 'LIKE':
        Get.toNamed(
          AppRoutes.POST_DETAIL,
          arguments: {'POST_ID': link.split('/').last},
        );
        break;

      case 'VOTE':
        if ((link.split('/').last) == 'vote') {
          await GetStorage().remove(StorageKeys.voteObjId);
          Get.toNamed(
            AppRoutes.MFP_VOTE_DASHBOARD,
            arguments: {'VOTE_ID': ''},
          );
        } else {
          final _controller = Get.put(MfpVoteDashboardController());
          await _controller.fetchGetVoteDetail(link.split('/').last);
        }
        break;

      default:
        break;
    }
  }
}
