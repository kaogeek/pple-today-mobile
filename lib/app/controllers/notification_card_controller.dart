import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/notification_search_model.dart';
import '../data/models/read_notification_model.dart';
import '../data/services/notification_service.dart';
import '../ui/utils/storage_keys.dart';

class NotificationCardController extends GetxController {
  final _service = NotificationService();
  final _box = GetStorage();

  @override
  void onInit() {
    fetchNotificationUnreadSearch();
    fetchNotificationSearch();
    super.onInit();
  }

  @override
  void onClose() {
    fetchReadAllNotification();
    super.onClose();
  }

  NotificationSearchModel notificationAllModel = NotificationSearchModel();
  NotificationSearchModel notificationUnReadModel = NotificationSearchModel();
  ReadNotificationModel readNotificationModel = ReadNotificationModel();

  List<String> listType = ['POST', 'LIKE', 'COMMENT'];
  int selectedIndex = 0;

  void onItemTapped(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      update();
    }
  }

  Future<void> onRefresh() async {
    selectedIndex == 0 ? await fetchNotificationUnreadSearch() : await fetchNotificationSearch();
    return;
  }

  Future<void> onLoadMore() async {
    selectedIndex == 0
        ? await fetchNotificationUnreadSearch(offset: notificationUnReadModel.data!.length)
        : await fetchNotificationSearch(offset: notificationAllModel.data!.length);
    return;
  }

  Future<NotificationSearchModel> fetchNotificationSearch({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      Response response = await _service.getNotificationSearch(
        offset: offset,
        limit: limit,
        isRead: true,
        mode: mode,
        token: token,
      );

      if (response.isOk) {
        final model = NotificationSearchModel.fromJson(response.body);

        offset != 0 ? notificationAllModel.data!.addAll(model.data ?? []) : notificationAllModel = model;

        notificationAllModel.data?.removeWhere((element) => element.notification!.type == 'CHAT');
      } else {
        notificationAllModel = NotificationSearchModel(
          status: 0,
          message: 'Sorry, the network is down.',
        );
      }
    } catch (e) {
      notificationAllModel = NotificationSearchModel(
        status: 0,
        message: 'Sorry, the network is down.',
      );
      printError(info: e.toString());
    }

    update();
    return notificationAllModel;
  }

  Future<NotificationSearchModel> fetchNotificationUnreadSearch({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      Response response = await _service.getNotificationSearch(
        offset: offset,
        limit: limit,
        isRead: false,
        mode: mode,
        token: token,
      );

      if (response.isOk) {
        final model = NotificationSearchModel.fromJson(response.body);

        offset != 0 ? notificationUnReadModel.data!.addAll(model.data ?? []) : notificationUnReadModel = model;

        notificationUnReadModel.data?.removeWhere((element) => element.notification!.type == 'CHAT');
      } else {
        notificationUnReadModel = NotificationSearchModel(
          status: 0,
          message: 'Sorry, the network is down.',
        );
      }
    } catch (e) {
      notificationUnReadModel = NotificationSearchModel(
        status: 0,
        message: 'Sorry, the network is down.',
      );
      printError(info: e.toString());
    }

    update();
    return notificationUnReadModel;
  }

  Future<ReadNotificationModel> fetchReadNotification(String id) async {
    readNotificationModel = ReadNotificationModel();
    update();

    String token = _box.read(StorageKeys.token) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    String? result = await _service.readNotification(
      id: id,
      token: token,
      mode: mode,
    );

    if (result == null) {
      readNotificationModel = ReadNotificationModel(
        status: 0,
        message: 'Sorry, the network is down.',
      );
      update();

      return readNotificationModel;
    }

    final json = jsonDecode(result);
    readNotificationModel = ReadNotificationModel.fromJson(json);
    update();

    return readNotificationModel;
  }

  Future<void> fetchReadAllNotification() async {
    String token = _box.read(StorageKeys.token) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    await _service.readAllNotification(
      token: token,
      mode: mode,
    );
    return;
  }
}
