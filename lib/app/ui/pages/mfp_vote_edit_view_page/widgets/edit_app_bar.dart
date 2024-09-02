import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_edit_view_controller.dart';
import '../../../utils/assets.dart';

class EditAppBar extends GetWidget<MfpVoteEditViewController> implements PreferredSizeWidget {
  const EditAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back(
            result: {'DATA': controller.editVoteItemModel.value},
          );
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      title: Text(
        'แก้ไขโหวต',
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
