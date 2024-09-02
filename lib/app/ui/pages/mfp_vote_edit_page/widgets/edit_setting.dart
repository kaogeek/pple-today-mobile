import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_edit_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import 'group.dart';

class EditSetting extends GetWidget<MfpVoteEditController> {
  const EditSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Group(
      groupName: 'ตั้งค่าโหวต',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(
              'ผู้มีสิทธิ์โหวต',
              style: TextStyle(
                fontSize: 14,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
            ),
            trailing: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: kPrimaryColor.withAlpha(50),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                value: 1, // controller.editVoteItemModel.value.type == 'member' ? 1 : 2,
                onChanged: null,
                underline: Container(),
                style: TextStyle(
                  fontSize: 14,
                  color: kPrimaryColor,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                ),
                items: const [
                  DropdownMenuItem(
                    child: Text('เฉพาะสมาชิก'),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text('ทุกคน'),
                    value: 2,
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(
              'เปิดโหวต',
              style: TextStyle(
                fontSize: 14,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// This Widget TextField Number of Vote Open Day ex. 15 days BackgroudColor: kPrimaryColor withAlpha(50)
                Container(
                  width: 80,
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: controller.openVoteController,
                    onChanged: (String value) {
                      value = value.isEmpty ? '0' : value;
                      // controller.editVoteItemModel.update((val) {
                      //   val!.voteDaysRange = int.parse(value);
                      // });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      // isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 28, bottom: 12),
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: kPrimaryColor,
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'วัน',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: Assets.assetsFontsAnakotmaiMedium,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Obx(() => SwitchListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(
                  'แสดงผลเมื่อปิดโหวตเท่านั้น',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: Assets.assetsFontsAnakotmaiMedium,
                  ),
                ),
                value: controller.showVoteResult.value,
                activeColor: kPrimaryColor,
                onChanged: (bool value) {
                  controller.showVoteResult.value = value;
                  // controller.editVoteItemModel.update((val) {
                  //   val!.showVoteResult = value;
                  // });
                },
              )),
          const Divider(),
          Obx(() => SwitchListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(
                  'แสดงชื่อผู้โหวต',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: Assets.assetsFontsAnakotmaiMedium,
                  ),
                ),
                value: controller.showVoteName.value,
                activeColor: kPrimaryColor,
                onChanged: (bool value) {
                  controller.showVoteName.value = value;
                  // controller.editVoteItemModel.update((val) {
                  //   val!.showVoteName = value;
                  // });
                },
              )),
          const Divider(),
        ],
      ),
    );
  }
}
