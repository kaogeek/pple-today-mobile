// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/mfp_vote_dashboard_controller.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import '../../utils/storage_keys.dart';
import 'widgets/view_vote_all.dart';
import 'widgets/view_vote_my_create.dart';
import 'widgets/view_vote_results.dart';
import 'widgets/view_vote_support.dart';
import 'widgets/view_vote_open.dart';

class MfpVoteDashboardPage extends GetView<MfpVoteDashboardController> {
  MfpVoteDashboardPage({Key? key}) : super(key: key);

  @override
  MfpVoteDashboardController controller = Get.put(MfpVoteDashboardController());

  final GetStorage _storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    final _token = _storage.read(StorageKeys.token) ?? '';

    return DefaultTabController(
      length: _token.isNotEmpty ? 5 : 4,
      child: MainLayoutView(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () => Get.back(),
          ),
          centerTitle: true,
          title: const Text(
            'ประชาชน Vote',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.MFP_VOTE_SEACH);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            if ((_storage.read(StorageKeys.token) ?? '').isNotEmpty && ((_storage.read(StorageKeys.whiteList) ?? false) || (_storage.read(StorageKeys.allowCreate) ?? false)))
              IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.MFP_VOTE_CREATE);
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: kPrimaryColor,
                ),
              ),
          ],
          bottom: TabBar(
            isScrollable: _token.isNotEmpty ? true : false,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            indicatorPadding: const EdgeInsets.only(top: 8, bottom: 12),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: kPrimaryMFPColor,
            ),
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 12,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
            ),
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
            ),
            tabs: [
              const Tab(text: 'ทั้งหมด'),
              if (_token.isNotEmpty) const Tab(text: 'ที่ฉันมีส่วนร่วม'),
              const Tab(text: 'เปิดโหวต'),
              const Tab(text: 'ล่ารายชื่อ'),
              const Tab(text: 'ดูผลโหวต'),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ViewVoteAll(),
            if (_token.isNotEmpty) ViewVoteMyCreate(),
            ViewVoteOpen(),
            ViewVoteSupport(),
            ViewVoteResults(),
          ],
        ),
      ),
    );
  }
}
