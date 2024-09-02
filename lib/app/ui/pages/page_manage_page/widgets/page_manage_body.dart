// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/page_profile_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/environment.dart';
import 'manage_page_item.dart';

class PageManageBody extends StatelessWidget {
  PageManageBody({Key? key}) : super(key: key);

  PageProfileController pageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'ข้อมูลเพจ',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: Assets.assetsFontsAnakotmaiMedium,
                  ),
                ),
              ),
              ManagePageItem(
                labelText: 'ชื่อเพจ',
                value: pageController.pageModel.data?.name ?? '',
              ),
              ManagePageItem(
                labelText: 'URL ของเพจ',
                detail: '${Environment.domainName}/@${pageController.pageModel.data?.pageUsername}',
                value: pageController.pageModel.data?.pageUsername ?? '',
                prefixIcon: const Icon(
                  Icons.alternate_email_rounded,
                  size: 18,
                  color: textGrey,
                ),
              ),
              ManagePageItem(
                labelText: 'ความเป็นมา',
                value: pageController.pageModel.data?.backgroundStory ?? '',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'ติดต่อ',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: Assets.assetsFontsAnakotmaiMedium,
                  ),
                ),
              ),
              ManagePageItem(
                labelText: 'เว็บไซต์',
                value: pageController.pageModel.data?.websiteUrl ?? '',
              ),
              ManagePageItem(
                labelText: 'อีเมล',
                value: pageController.pageModel.data?.email ?? '',
              ),
              ManagePageItem(
                labelText: 'ไลน์',
                value: pageController.pageModel.data?.lineId ?? '',
              ),
              ManagePageItem(
                labelText: 'เฟซบุ๊ค',
                value: pageController.pageModel.data?.facebookUrl ?? '',
              ),
              ManagePageItem(
                labelText: 'ทวิตเตอร์',
                value: pageController.pageModel.data?.twitterUrl ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
