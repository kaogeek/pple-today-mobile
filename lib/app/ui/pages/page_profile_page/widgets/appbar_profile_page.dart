// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../component/bottom_sheet_ugc.dart';
import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/page_profile_controller.dart';
import '../../../../controllers/user_generated_content_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/storage_keys.dart';

class AppBarProfilePage extends StatelessWidget {
  AppBarProfilePage({Key? key}) : super(key: key);

  PageProfileController controller = Get.put(PageProfileController());
  UserGeneratedContentController ugcController = Get.put(UserGeneratedContentController());

  final String _uid = GetStorage().read(StorageKeys.uid) ?? '';

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: BackButton(
        color: kPrimaryColor,
        onPressed: () => Get.back(),
      ),
      title: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(controller.pageModel.data?.imageUrl ?? Assets.placeholderPerson),
        ),
        title: Text(
          controller.pageModel.data?.name ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      // *UGC
      actions: [
        if (controller.pageModel.data != null)
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: primaryBlue,
            ),
            onPressed: _onReportBottomSheet,
          ),
      ],
    );
  }

  // *UGC
  Future<void> _onReportBottomSheet() async {
    final _data = controller.pageModel.data!;

    (_data.ownerUser ?? '') == _uid
        ? await showModalBottomSheet(
            context: Get.context!,
            builder: (context) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text(
                        'จัดการเพจ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        Get.back();
                        Get.toNamed(
                          AppRoutes.PAGE_MANAGE,
                          arguments: {'PAGE_ID': _data.id},
                        )?.then((_) {
                          controller.fetchPage(_data.id!);
                          controller.fetchPagePostSearch(_data.id!);
                        });
                      },
                    ),
                  ],
                ),
              );
            })
        : await bottomSheetUGC(
            onReportPage: ((ugcController.manipulatePageModel.data ?? []).isEmpty)
                ? null
                : () {
                    showModalBottomSheet(
                      context: Get.context!,
                      builder: (context) {
                        return SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: ugcController.manipulatePageModel.data!.asMap().entries.map((e) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 0.1,
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    onTap: () async {
                                      await Get.defaultDialog(
                                        title: e.value.detail ?? '',
                                        content: TextField(
                                          controller: ugcController.msgReportTextController,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            hintText: 'คุณสามารถใส่รายละเอียดเพิ่มเติมได้ที่นี่...',
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        textCancel: 'ปิด',
                                        textConfirm: 'ตกลง',
                                        cancelTextColor: Colors.black,
                                        confirmTextColor: kPrimaryColor,
                                        buttonColor: Colors.white,
                                        onConfirm: () async {
                                          ugcController.fetchReportPostPageUser(
                                            id: _data.id!,
                                            type: 'PAGE',
                                            topic: e.value.detail ?? '',
                                            message: ugcController.msgReportTextController.text,
                                          );

                                          Get.back(); // close dialog
                                          Get.back(); // close bottom sheet

                                          await 300.milliseconds.delay();
                                          SnackBarComponent.show(
                                            title: 'คุณได้รายงานเพจนี้แล้ว',
                                            type: SnackBarType.info,
                                          );
                                        },
                                      ).then((_) {
                                        ugcController.msgReportTextController.clear();
                                        ugcController.update();
                                      });
                                    },
                                    title: Text(e.value.detail ?? ''),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    );
                  },
            onBlock: () async {
              String pageId = _data.id ?? '';
              String pageName = _data.name ?? '';

              ugcController.fetchBlockPageUser(
                id: pageId,
                type: 'PAGE',
              );

              Get.back(); // close profile page

              await 300.milliseconds.delay();
              SnackBarComponent.show(
                title: 'คุณได้บล็อคเพจ\n$pageName แล้ว',
                type: SnackBarType.info,
              );
            },
          );

    return;
  }
}
