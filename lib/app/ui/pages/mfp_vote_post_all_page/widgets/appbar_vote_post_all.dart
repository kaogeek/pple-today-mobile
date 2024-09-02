import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/storage_keys.dart';

class AppBarVotePostAll extends StatelessWidget implements PreferredSizeWidget {
  const AppBarVotePostAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(
        color: Colors.black,
        onPressed: () {
          if (Get.currentRoute == AppRoutes.MFP_VOTE_POST_ALL) Get.back();
        },
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
        if ((GetStorage().read(StorageKeys.token) ?? '').isNotEmpty)
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
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56.0);
}
