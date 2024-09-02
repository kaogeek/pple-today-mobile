// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:developer';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../component/mfp_dialog.dart';
import '../data/models/notification_search_model.dart';
import '../data/services/analytics_service.dart';
import '../data/services/notification_service.dart';
import '../data/services/user_service.dart';
import '../routes/app_routes.dart';
import '../ui/utils/log.dart';
import '../ui/utils/storage_keys.dart';
import 'app_lifecycle_state_controller.dart';
import 'doing_controller.dart';
import 'profile_controller.dart';
import 'today_controller.dart';
import 'user_generated_content_controller.dart';

class DashboardController extends GetxController {
  final _notiService = NotificationService();
  final _userService = UserService();
  final _box = GetStorage();

  final _appLifecycleStateController = Get.put(AppLifecycleStateController());
  final _todayController = Get.put(TodayController());
  final _doingController = Get.put(DoingController());
  final _profileController = Get.put(ProfileController());
  final _ugcController = Get.put(UserGeneratedContentController());

  final _disabledUpdate = false.obs;
  bool get disabledUpdate => _disabledUpdate.value;
  set disabledUpdate(bool value) => _disabledUpdate.value = value;

  ScrollController scrollController1 = ScrollController();
  ScrollController scrollController2 = ScrollController();
  ScrollController scrollController3 = ScrollController();
  ScrollController scrollController4 = ScrollController();

  int countNoti = 0;
  int selectedIndex = 0;

  bool isLoadMore = false;

  @override
  void onInit() {
    super.onInit();
    scrollController1.addListener(() => _onLoadMore1());
    scrollController2.addListener(() => _onLoadMore2());
    // scrollController3.addListener(() => _onLoadMore());
    // scrollController4.addListener(() => _onLoadMore());


    debugPrint("disabledUpdate : ${_box.read(StorageKeys.disablesUpdate)}", wrapWidth: 1024);
    disabledUpdate = _box.read(StorageKeys.disablesUpdate) ?? false;
    update();

    fetchCountNotification();
    _ugcController.fetchManipulateUser();
    _ugcController.fetchManipulatePost();
    _ugcController.fetchManipulatePage();
    _profileController.fetchUserAccessPage();
    _profileController.fetchProfileUser();
    fetchGetPermissible();
    _requestTracking();

    _appLifecycleStateController.fetchFirebaseOpenedApp().then((value) {
      if (value) {
        1.seconds.delay(() {
          String uid = _box.read(StorageKeys.uid) ?? '';
          bool member = _box.read(StorageKeys.memberShip) ?? false;
          bool popup = _box.read(StorageKeys.popUpMemberShip) ?? false;

          if (uid.isNotEmpty && !member && !popup) Mfp.memberBindingDialog();
        });
      } else {
        _appLifecycleStateController.initUniLinks();
      }
    });

    AnalyticsService().logScreen(name: AppRoutes.DASHBOARD);
    // AnalyticsService().setUserProperties(userId: _box.read(StorageKeys.uid) ?? '');
  }

  Future<void> _requestTracking() async {
    await 500.milliseconds.delay(() async {
      if (GetPlatform.isIOS) await AppTrackingTransparency.requestTrackingAuthorization();
    });
    return;
  }

  void onItemTapped(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      update();
    } else {
      if (index == 0) {
        if (scrollController1.offset > 0) {
          _topScrollExtent1();
        } else {
          onRefresh();
        }
      } else if (index == 1) {
        if (scrollController2.offset > 0) {
          _topScrollExtent2();
        } else {
          onRefresh();
        }
      } else if (index == 2) {
        onRefresh();
      } else if (index == 3) {
        onRefresh();
      }
    }
  }

  Future<void> onRefresh() async {
    switch (selectedIndex) {
      case 0:
        _todayController.offsetStory = 0;
        _todayController.isNotPostStory = false;
        _todayController.isRefresh = true;
        _todayController.update();

        await _todayController.fetchAnnouncement();
        await _todayController.fetchMergencyEvents();
        await _todayController.fetchRecommendedUserPage();
        await _todayController.fetchPostStory();

        _todayController.isRefresh = false;
        _todayController.update();
        break;

      // case 1:
      //   _firstController.fetchMergencyEvents();
      //   break;

      case 2:
        await _doingController.fetchGetDoing();
        await _doingController.fetchGetObjectivDoing();
        break;
    }
    return;
  }

  Future<void> _onLoadMore1() async {
    bool nextPostTrigger = scrollController1.position.extentAfter < 1000;

    if (nextPostTrigger && !isLoadMore) {
      if (!_todayController.isNotPostStory) {
        isLoadMore = true;
        update();

        _todayController.offsetStory += 10;
        await _todayController.fetchRecommendedUserPage();
        await _todayController.fetchPostStory(offset: _todayController.offsetStory);

        isLoadMore = false;
        update();
      }
    }
  }

  Future<void> _onLoadMore2() async {
    bool nextPostTrigger = scrollController2.position.extentAfter < 1000;

    if (nextPostTrigger && !isLoadMore) {
      if (!_doingController.isNotPost) {
        isLoadMore = true;
        _doingController.update();

        _doingController.offsetObjective += 10;
        await _doingController.fetchGetObjectivDoing(offset: _doingController.offsetObjective);

        isLoadMore = false;
        update();
      }
    }
  }

  void _topScrollExtent1() {
    if (scrollController1.offset > 0) {
      scrollController1.animateTo(
        scrollController1.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
  }

  void _topScrollExtent2() {
    if (scrollController2.offset > 0) {
      scrollController2.animateTo(
        scrollController2.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
  }

  /* Future<void> _maxScrollExtent() async {
    await 300.milliseconds.delay(() {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent - 10,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    });
  } */

  Future<void> fetchCountNotification() async {
    try {
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      Response response = await _notiService.getNotificationSearch(
        offset: 0,
        limit: 20,
        isRead: false,
        mode: mode,
        token: token,
      );

      if (response.isOk) {
        var model = NotificationSearchModel.fromJson(response.body);

        (model.data ?? []).isEmpty ? countNoti = 0 : countNoti = model.data!.length;
      } else {
        countNoti = 0;
      }
    } catch (e) {
      countNoti = 0;
      printError(info: e.toString());
    }

    update();
    return;
  }

  Future<void> fetchGetPermissible() async {
    String token = _box.read(StorageKeys.token) ?? '';
    if (token.isEmpty) return;

    // bool whiteList = _box.read(StorageKeys.whiteList) ?? false;
    // if (whiteList) return;

    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _userService.getPermissible(
        token: token,
        uid: uid,
        mode: mode,
      );

      if (response.isOk && response.body['status'] == 1) {
        Log.print('whiteList: true');
        await GetStorage().write(StorageKeys.whiteList, true);
      } else {
        Log.print('whiteList: false');
        await GetStorage().write(StorageKeys.whiteList, false);
      }
    } catch (e) {
      log('', error: e, name: 'fetchGetPermissible');
      Log.print('whiteList: false');
      await GetStorage().write(StorageKeys.whiteList, false);
    }

    return;
  }
}
