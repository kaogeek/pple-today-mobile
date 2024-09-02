import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_edit_item_controller.dart';
import '../../../utils/assets.dart';

class MyAppBar extends GetWidget<MfpVoteEditItemController> implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: controller.onBack,
        icon: const Icon(Icons.close),
        color: Colors.black,
      ),
      title: Obx(() => Text(
            'คำถามที่${controller.index + 1}\t${controller.editItemModel.value.voteItem![controller.index].type!.name}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
            ),
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
