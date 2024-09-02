import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_edit_controller.dart';
import '../../../utils/assets.dart';
import 'group.dart';

class EditAs extends GetWidget<MfpVoteEditController> {
  const EditAs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Group(
      groupName: 'สร้างโหวตโดย',
      child: Container(
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: ListTile(
          enabled: false,
          leading: (controller.editVoteItemModel.value.user?.imageUrl ?? '').isNotEmpty
              ? CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  backgroundImage: NetworkImage(controller.editVoteItemModel.value.user!.imageUrl!),
                )
              : (controller.editVoteItemModel.value.page?.imageUrl ?? '').isNotEmpty
                  ? CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      backgroundImage: NetworkImage(controller.editVoteItemModel.value.page!.imageUrl!),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      backgroundImage: const AssetImage(Assets.assetsImagesUser),
                    ),
          title: Text(
            controller.editVoteItemModel.value.user?.name ?? controller.editVoteItemModel.value.page?.name ?? '',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
            ),
          ),
        ),
      ),
    );
  }
}
