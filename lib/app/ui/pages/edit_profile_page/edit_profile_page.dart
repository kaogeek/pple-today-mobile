import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../component/list_tile_component.dart';
import '../../../component/loading.dart';
import '../../../component/my_dialog.dart';
import '../../../controllers/edit_profile_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/enum.dart';
import 'widgets/porofile_name.dart';
import 'widgets/profile_list_tile.dart';

class EditProfilePage extends GetView<EditProfileController> {
  EditProfilePage({super.key});

  final _profileController = Get.put(ProfileController());
  final _f = DateFormat('dd MMM yyyy', 'th');

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: AppBar(
        elevation: .3,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'แก้ไขโปรไฟล์',
          style: Get.textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontFamily: Assets.assetsFontsAnakotmaiMedium,
          ),
        ),
        // actions: controller.profileImage.path.isEmpty
        //     ? null
        //     : [
        //         TextButton(
        //           onPressed: _submitPic,
        //           child: Text(
        //             'บันทึก',
        //             style: Get.textTheme.bodyText1?.copyWith(
        //               color: kPrimaryColor,
        //               fontFamily: Assets.assetsFontsAnakotmaiMedium,
        //               fontSize: 18,
        //             ),
        //           ),
        //         ),
        //       ],
      ),
      body: Center(
        child: GetBuilder<ProfileController>(
          init: ProfileController(),
          initState: (_) {},
          builder: (_) {
            return Column(
              children: [
                Column(
                  children: [
                    ProfileName(),
                    ProfileListTile(
                      titleText: 'ชื่อ',
                      subTitleText: '${_profileController.profileModel.data?.firstName ?? ''} ${_profileController.profileModel.data?.lastName ?? ''}',
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.EDIT_PROFILE_TEXT_FIELD,
                          arguments: {
                            'TITLE': 'ชื่อ',
                            'HINT_TEXT': '${_profileController.profileModel.data?.firstName ?? ''} ${_profileController.profileModel.data?.lastName ?? ''}',
                          },
                        );
                      },
                    ),
                    ProfileListTile(
                      titleText: 'ชื่อผู้ใช้',
                      subTitleText: _profileController.profileModel.data?.displayName ?? '',
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.EDIT_PROFILE_TEXT_FIELD,
                          arguments: {
                            'TITLE': 'ชื่อผู้ใช้',
                            'HINT_TEXT': _profileController.profileModel.data?.displayName ?? '',
                          },
                        );
                      },
                    ),
                    ProfileListTile(
                      titleText: 'วันเกิด',
                      subTitleText: _profileController.profileModel.data?.birthdate == null ? '-' : _f.format(_profileController.profileModel.data!.birthdate!),
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.EDIT_PROFILE_TEXT_FIELD,
                          arguments: {
                            'TITLE': 'วันเกิด',
                            'HINT_TEXT': _profileController.profileModel.data!.birthdate!.toString(),
                          },
                        );
                      },
                    ),
                    SizedBox(height: 36),
                    ListTileComponent(
                      title: 'ลบบัญชี',
                      type: ListTileType.delete,
                      trailing: null,
                      onTap: () async {
                        await Get.defaultDialog(
                          title: 'ลบบัญชี',
                          titleStyle: TextStyle(
                            fontSize: 24,
                            fontFamily: Assets.assetsFontsAnakotmaiLight,
                            color: Colors.red,
                          ),
                          content: Text(
                            'ยืนยันที่จะลบบัญชีผู้ใช้นี้ หรือไม่?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: Assets.assetsFontsAnakotmaiLight,
                            ),
                          ),
                          textCancel: 'ปิด',
                          textConfirm: 'ยืนยัน',
                          cancelTextColor: Colors.black,
                          confirmTextColor: Colors.red,
                          onConfirm: () async {
                            Get.back(); // close dialog

                            Loading.show();
                            await controller.fetchDeleteAccountUser().then((value) async {
                              Loading.dismiss();

                              if (value) {
                                await MyDialog.defaultDialog(
                                  title: 'ลบบัญชี',
                                  content: 'ระบบจะทำการลบบัญชีผู้ใช้นี้ภายใน 1 ชั่วโมง',
                                );

                                await GetStorage().erase();

                                Get.offAllNamed(AppRoutes.SPLASH);
                              } else {
                                MyDialog.defaultDialog(
                                  title: 'เกิดข้อผิดพลาด',
                                  content: 'ขออภัย เกิดข้อผิดพลาดในการเชื่อมต่อระบบ',
                                );
                              }
                            });
                          },
                          buttonColor: Colors.white,
                        );
                        return;
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
