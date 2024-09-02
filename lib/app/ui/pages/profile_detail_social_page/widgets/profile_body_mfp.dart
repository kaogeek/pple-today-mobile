import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/profile_controller.dart';
import 'porofile_image.dart';
import 'profile_list_tile.dart';
import 'unbinding_button.dart';

class ProfileMFP extends GetWidget<ProfileController> {
  ProfileMFP({Key? key}) : super(key: key);

  final _f = DateFormat('dd/MM/yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const ProfileImage(),
          ProfileListTile(
            titleText: 'ชื่อ',
            subTitleText: controller.profileModel.data?.mfpUser?.firstName ?? '',
          ),
          ProfileListTile(
            titleText: 'นามสกุล',
            subTitleText: controller.profileModel.data?.mfpUser?.lastName ?? '',
          ),
          ProfileListTile(
            titleText: 'อีเมล์',
            subTitleText: controller.profileModel.data?.mfpUser?.email ?? '',
          ),
          // ProfileListTile(
          //   titleText: 'รหัสสมาชิก',
          //   subTitleText: controller.profileModel.data?.mfpUser?.id ?? '',
          // ),
          ProfileListTile(
            titleText: 'บัตรประชาชน',
            subTitleText: controller.profileModel.data?.mfpUser?.personCardId ?? '',
          ),
          ProfileListTile(
            titleText: 'เบอร์มือถือ',
            subTitleText: controller.profileModel.data?.mfpUser?.phoneNumber ?? '',
          ),
          ProfileListTile(
            titleText: 'สถานะ',
            subTitleText: () {
              switch (controller.profileModel.data?.mfpUser?.status) {
                case 'APPROVED':
                  return 'ผ่านการตรวจสอบแล้ว';

                case 'PENDING_PAYMENT':
                  return 'รอการชำระเงิน';

                case 'PENDING_APPROVAL':
                  return 'รอการตรวจสอบ';

                case 'REJECTED':
                  return 'ไม่ผ่านการตรวจสอบ';

                case 'PROFILE_RECHECKED':
                  return 'สมาชิกรอจัดเก็บ';

                case 'ARCHIVED':
                  return 'สมาชิกที่จัดเก็บแล้ว';

                default:
                  return 'ไม่ระบุ';
              }
            }(),
            subTitleColor: () {
              switch (controller.profileModel.data?.mfpUser?.status) {
                case 'APPROVED':
                  return Colors.green;

                case 'PENDING_PAYMENT':
                  return Colors.orange;

                case 'PENDING_APPROVAL':
                  return Colors.orange;

                case 'REJECTED':
                  return Colors.red;

                case 'PROFILE_RECHECKED':
                  return Colors.yellow;

                case 'ARCHIVED':
                  return Colors.yellow;

                default:
                  return null;
              }
            }(),
          ),
          ProfileListTile(
            titleText: 'วันหมดอายุสมาชิก',
            subTitleText: controller.profileModel.data?.mfpUser?.expiredAt != null
                ? _f.format(controller.profileModel.data!.mfpUser!.expiredAt!)
                : '',
          ),
          UnbindingButton(),
        ],
      ),
    );
  }
}
