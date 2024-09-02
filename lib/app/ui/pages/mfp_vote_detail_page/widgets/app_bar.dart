import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_detail_controller.dart';
import '../../../../routes/app_routes.dart';

class MyAppBar extends GetWidget<MfpVoteDetailController> implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (Get.currentRoute == AppRoutes.MFP_VOTE_DETAIL) Get.back();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
