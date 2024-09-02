import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/notification_card_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class NotificationCardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NotificationCardAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      leading: BackButton(
        color: kPrimaryColor,
        onPressed: () => Get.back(),
      ),
      title: Text(
        'การแจ้งเตือน',
        style: TextStyle(
          fontSize: 18,
          fontFamily: Assets.assetsFontsAnakotmaiLight,
          color: textDark,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(25),
            ),
            child: GetBuilder<NotificationCardController>(
              init: NotificationCardController(),
              initState: (_) {},
              builder: (controller) {
                return TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: kPrimaryColor,
                  ),
                  labelColor: Colors.white,
                  labelStyle: TextStyle(
                    fontFamily: Assets.assetsFontsAnakotmaiLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: 'ยังไม่ได้อ่าน'),
                    Tab(text: 'ทั้งหมด'),
                  ],
                  onTap: controller.onItemTapped,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kToolbarHeight);
}
