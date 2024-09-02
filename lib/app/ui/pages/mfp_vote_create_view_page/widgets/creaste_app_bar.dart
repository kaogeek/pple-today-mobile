import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_create_view_controller.dart';
import '../../../utils/assets.dart';

class CreasteAppBar extends GetWidget<MfpVoteCreateViewController> implements PreferredSizeWidget {
  const CreasteAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back(
            result: {'DATA': controller.createItemModel.value},
          );
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      title: Text(
        'สร้างโหวต',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: Assets.assetsFontsAnakotmaiMedium,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
