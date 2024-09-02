// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/detail_first_controller.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import 'widgets/emergency_events.dart';
import 'widgets/post_card.dart';
import 'widgets/post_card_list_tile.dart';
import 'widgets/post_topic.dart';

class DetailFirstPage extends GetView<DetailFirstController> {
  const DetailFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _format = context.isPhone ? DateFormat('dd MMM yyyy', 'th_TH') : DateFormat('dd MMMM yyyy', 'th_TH');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kPrimaryMFPColor,
          ),
        ),
        centerTitle: false,
        title: Obx(() => AutoSizeText(
              'ฉบับวันที่\r' '${_format.format(controller.dateFirstPage.value)}',
              maxLines: 1,
              minFontSize: 14,
              maxFontSize: context.isPhone ? 24 : 32,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kPrimaryMFPColor,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                fontSize: context.isPhone ? 24 : 32,
              ),
            )),
        actions: [
          Semantics(
            label: 'ปฏิทิน',
            onTap: _openCalendar,
            child: IconButton(
              padding: EdgeInsets.only(right: context.isPhone ? 0 : 16),
              onPressed: _openCalendar,
              icon: Icon(
                Icons.calendar_month_outlined,
                color: kPrimaryMFPColor,
                size: context.isPhone ? 32 : 40,
              ),
            ),
          ),
        ],
        /* bottom: TabBar(
          isScrollable: true,
          indicatorColor: kPrimaryColor,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black87,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: kPrimaryMFPColor,
          ),
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: kPrimaryMFPColor,
                    width: 1,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'วันนี้',
                    style: TextStyle(
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: kPrimaryMFPColor,
                    width: 1,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'หน้าหนึ่ง',
                    style: TextStyle(
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: kPrimaryMFPColor,
                    width: 1,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'กำลังทำ',
                    style: TextStyle(
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: kPrimaryMFPColor,
                    width: 1,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'เมนู',
                    style: TextStyle(
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ), */
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isShowLoading.value) {
            return SizedBox(
              width: Get.width,
              height: Get.height - (kToolbarHeight - kBottomNavigationBarHeight - 16),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final _data = controller.contentModel.value.data;

          if ((_data?.emergencyEvents?.contents ?? []).isEmpty &&
              (_data?.pageRoundRobin?.contents ?? []).isEmpty &&
              (_data?.majorTrend?.contents ?? []).isEmpty &&
              (_data?.kaokaiProvince?.contents ?? []).isEmpty &&
              (_data?.kaokaiHashTag?.contents ?? []).isEmpty &&
              (_data?.kaokaiContent?.contents ?? []).isEmpty) {
            return SizedBox(
              width: Get.width,
              height: Get.height - (kToolbarHeight - kBottomNavigationBarHeight - 16),
              child: Center(
                child: Text(
                  'ไม่มีข้อมูล',
                  style: TextStyle(fontSize: context.isPhone ? 24 : 32),
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostTopic(
                  (_data?.pageRoundRobin?.contents ?? []).isNotEmpty
                      ? _data!.pageRoundRobin!.contents!.first
                      : (_data?.majorTrend?.contents ?? []).isNotEmpty
                          ? _data!.majorTrend!.contents!.first
                          : (_data?.kaokaiProvince?.contents ?? []).isNotEmpty
                              ? _data!.kaokaiProvince?.contents!.first
                              : (_data?.kaokaiHashTag?.contents ?? []).isNotEmpty
                                  ? _data!.kaokaiHashTag!.contents!.first
                                  : (_data?.kaokaiContent?.contents ?? []).isNotEmpty
                                      ? _data!.kaokaiContent!.contents!.first
                                      : _data?.emergencyEvents?.contents?.first,
                ),
                PostCard(_data?.pageRoundRobin),
                if (((_data?.pageRoundRobin?.contents ?? []).length > 1 ||
                        (_data?.majorTrend?.contents ?? []).length > 1 ||
                        (_data?.kaokaiProvince?.contents ?? []).length > 1 ||
                        (_data?.kaokaiHashTag?.contents ?? []).length > 1 ||
                        (_data?.kaokaiContent?.contents ?? []).length > 1) &&
                    (_data?.emergencyEvents?.contents ?? []).isNotEmpty)
                  EmergencyEvents(_data!.emergencyEvents),
                PostCardListTile(_data?.majorTrend),
                PostCardListTile(_data?.kaokaiProvince),
                PostCardListTile(_data?.kaokaiHashTag),
                PostCardListTile(_data?.kaokaiContent),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _openCalendar() {
    final _size = Get.context!.isPhone ? 300.0 : 480.0;

    Get.defaultDialog(
      title: 'เลือกวันที่',
      content: Center(
        child: SizedBox(
          width: _size,
          height: _size,
          child: Obx(() => CalendarDatePicker(
                initialDate: controller.dateFirstPage.value,
                firstDate: DateTime(2021),
                lastDate: DateTime.now().add(const Duration(days: 100000)),
                selectableDayPredicate: (DateTime date) {
                  return date.isBefore(DateTime.now());
                },
                onDateChanged: (DateTime newDate) {
                  controller.dateFirstPage.value = newDate;
                  Get.back();
                  controller.fetchMergencyEvents(date: newDate);
                },
              )),
        ),
      ),
    );
  }
}
