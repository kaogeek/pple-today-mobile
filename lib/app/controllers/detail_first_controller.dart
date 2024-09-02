import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/content_model.dart' as c;
import '../data/services/today_service.dart';

class DetailFirstController extends GetxController with GetSingleTickerProviderStateMixin {
  final _service = TodayService();
  final timeStamp = Get.arguments['TIME_STAMP'];
  // final date = Get.arguments['DATE'];

  Rx<DateTime> dateFirstPage = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).obs;

  Rx<c.ContentModel> contentModel = c.ContentModel().obs;
  RxBool isShowLoading = false.obs;

  @override
  void onInit() {
    /// check if date is before today
    DateTime date = DateTime.parse(timeStamp.toString().split('T').first);
    dateFirstPage.value = date.isBefore(DateTime.now())
        ? date
        : DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          );

    ///
    super.onInit();
  }

  @override
  void onReady() {
    fetchMergencyEvents(date: dateFirstPage.value);
    super.onReady();
  }

  Future<void> fetchMergencyEvents({DateTime? date}) async {
    debugPrint('DATE: $date', wrapWidth: 1024);
    isShowLoading.value = true;
    contentModel.value = c.ContentModel();

    try {
      Response response = await _service.getMainContent(date: date);

      contentModel.value = c.ContentModel.fromJson(date != null ? response.body['data'] : response.body);

      /*   /// sort pageRoundRobin
      if ((contentModel.value.data?.pageRoundRobin?.contents ?? []).isNotEmpty) {
        contentModel.value.data?.pageRoundRobin!.contents!.sort((a, b) => a.post!.createdDate!.compareTo(b.post!.createdDate!));
      }

      /// sort majorTrend
      if ((contentModel.value.data?.majorTrend?.contents ?? []).isNotEmpty) {
        contentModel.value.data?.majorTrend!.contents!.sort((a, b) => a.post!.createdDate!.compareTo(b.post!.createdDate!));
      }

      /// sort kaokaiProvince
      if ((contentModel.value.data?.kaokaiProvince?.contents ?? []).isNotEmpty) {
        contentModel.value.data?.kaokaiProvince!.contents!.sort((a, b) => a.post!.createdDate!.compareTo(b.post!.createdDate!));
      }

      /// sort kaokaiHashTag
      if ((contentModel.value.data?.kaokaiHashTag?.contents ?? []).isNotEmpty) {
        contentModel.value.data?.kaokaiHashTag!.contents!.sort((a, b) => a.post!.createdDate!.compareTo(b.post!.createdDate!));
      }

      /// sort kaokaiContent
      if ((contentModel.value.data?.kaokaiContent?.contents ?? []).isNotEmpty) {
        contentModel.value.data?.kaokaiContent!.contents!.sort((a, b) => a.post!.createdDate!.compareTo(b.post!.createdDate!));
      } */
    } catch (e) {
      log('', error: e, name: 'fetchMergencyEvents');
      contentModel.value = c.ContentModel(
        status: 0,
        message: 'ขออภัย เกิดข้อผิดพลาดในการเชื่อมต่อระบบ',
        data: c.Data(
          emergencyEvents: c.EmergencyEvents(contents: []),
          emergencyPin: c.EmergencyPin(contents: []),
          postSectionModel: c.PostSectionModel(contents: []),
          pageRoundRobin: c.PageRoundRobin(contents: []),
          objectiveEvents: c.ObjectiveEvents(contents: []),
        ),
      );
    }

    isShowLoading.value = false;
    return;
  }
}
