import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_create_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import 'group.dart';

class CreateSetting extends GetWidget<MfpVoteCreateController> {
  const CreateSetting({Key? key}) : super(key: key);

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
              child: ObxValue(
                  (RxInt val) => DropdownButton(
                        value: val.value,
                        onChanged: (int? value) {
                          val.value = value ?? 1;
                          controller.type.value = value == 1 ? 'member' : 'public';
                        },
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
                          // DropdownMenuItem(
                          //   child: Text('ทุกคน'),
                          //   value: 2,
                          // ),
                        ],
                      ),
                  1.obs),
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
                      controller.openVoteController.text = int.parse(value).toString();
                      controller.openVoteController.selection = TextSelection.fromPosition(TextPosition(offset: controller.openVoteController.text.length));
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
          /* ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(
              'กำหนดวันเริ่มโหวต',
              style: TextStyle(
                fontSize: 14,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
            ),

            /// subtitle Text Date Time ex. 08/08/2021 | 08:08
            subtitle: Obx(() => Text(
                  controller.startDate.value == null
                      ? ''
                      : '${controller.startDate.value!.day}/${controller.startDate.value!.month}/${controller.startDate.value!.year}\t\t\t|'
                          '\t\t\t${controller.startDate.value!.hour <= 9 ? '0${controller.startDate.value!.hour}' : controller.startDate.value!.hour}'
                          ':${controller.startDate.value!.minute <= 9 ? '0${controller.startDate.value!.minute}' : controller.startDate.value!.minute}',
                  style: const TextStyle(fontSize: 12),
                )),

            /// trailing Icon Open DateTimePicker
            trailing: IconButton(
              onPressed: () async {
                List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
                  context: context,
                  is24HourMode: true,
                  startInitialDate: controller.startDate.value,

                  /// DefaultEndDate 15 days and time 23 hours 59 minutes
                  endInitialDate: controller.endDate.value,
                );
                print('DATETIMELIST: $dateTimeList');

                if ((dateTimeList ?? []).isEmpty) return;

                controller.startDate.value = dateTimeList?.first;
                controller.endDate.value = dateTimeList?.last;
              },
              icon: const Icon(Icons.edit_calendar_rounded),
            ),
          ), */
          const Divider(),
          /* ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(
              'กำหนดวันปิดโหวต',
              style: TextStyle(
                fontSize: 14,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
            ),

            /// subtitle Text Date Time ex. 08/08/2021 08:08
            subtitle: Obx(() => Text(
                  controller.endDate.value == null
                      ? ''
                      : '${controller.endDate.value!.day}/${controller.endDate.value!.month}/${controller.endDate.value!.year}\t\t\t|'
                          '\t\t\t${controller.endDate.value!.hour <= 9 ? '0${controller.endDate.value!.hour}' : controller.endDate.value!.hour}'
                          ':${controller.endDate.value!.minute <= 9 ? '0${controller.endDate.value!.minute}' : controller.endDate.value!.minute}',
                  style: const TextStyle(fontSize: 12),
                )),

            /// trailing Icon Open DateTimePicker
            trailing: IconButton(
              onPressed: () async {
                List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
                  context: context,
                  is24HourMode: true,
                  startInitialDate: controller.startDate.value,

                  /// DefaultEndDate 15 days and time 23 hours 59 minutes
                  endInitialDate: controller.endDate.value,
                );
                print('DATETIMELIST: $dateTimeList');

                if ((dateTimeList ?? []).isEmpty) return;

                controller.startDate.value = dateTimeList?.first;
                controller.endDate.value = dateTimeList?.last;
              },
              icon: const Icon(Icons.edit_calendar_rounded),
            ),
          ), */
          // const Divider(),
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
                },
              )),
          const Divider(),
        ],
      ),
    );
  }
}
