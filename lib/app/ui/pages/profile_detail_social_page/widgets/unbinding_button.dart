import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../component/my_dialog.dart';
import '../../../../controllers/connect_social_media_controller.dart';
import '../../../../controllers/profile_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/storage_keys.dart';

class UnbindingButton extends GetWidget<ProfileController> {
  UnbindingButton({Key? key}) : super(key: key);

  final _box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        width: Get.width * .9,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            primary: Colors.white,
            shadowColor: Colors.transparent,
          ),
          onPressed: () async {
            await unbindingMFP();
          },
          child: Text(
            'ยกเลิกการเชื่อมบัญชี',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> unbindingMFP() async {
    await MyDialog.defaultDialog(
      title: '',
      content: 'คุณต้องการยกเลิกการผูกสมาชิก ใช่หรือไม่?',
      onConfirm: () async {
        ConnectSocialMediaController socialController = Get.find();
        await socialController.fetchUpdataMemberShip(membership: false);

        controller.profileModel.data!.mfpUser = null;
        controller.profileModel.data!.memberShip = false;
        controller.profileModel.data!.authUser!.remove('MFP');
        controller.update();

        await _box.remove(StorageKeys.memberShip);
        Get.back(); // close dialog
        Get.back(); // close page
      },
      textCancel: 'ปิด',
    );

    return;
  }
}
