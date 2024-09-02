// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/bottom_sheet_ugc.dart';
import '../../../../component/convert_time_componenet.dart';
import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/post_detail_controller.dart';
import '../../../../controllers/user_generated_content_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class PostDetailAppBar extends StatelessWidget {
  PostDetailAppBar({Key? key}) : super(key: key);

  PostDetailController controller = Get.put(PostDetailController());
  UserGeneratedContentController ugcController = Get.put(UserGeneratedContentController());

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      leading: BackButton(
        color: kPrimaryColor,
        onPressed: () => Get.back(),
      ),
      title: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: (controller.storyModel.data ?? []).isEmpty ||
                (controller.storyModel.data?.first.page ?? []).isEmpty ||
                (controller.storyModel.data?.first.page?.first.imageUrl ?? '').isEmpty
            ? CircleAvatar(
                backgroundImage: AssetImage(Assets.assetsImagesPlaceholderPerson),
              )
            : CircleAvatar(
                backgroundImage: NetworkImage(controller.storyModel.data!.first.page!.first.imageUrl!),
              ),
        title: Text(
          (controller.storyModel.data ?? []).isNotEmpty
              ? (controller.storyModel.data?.first.page ?? []).isNotEmpty &&
                      controller.storyModel.data?.first.page?.first.name != null
                  ? controller.storyModel.data!.first.page!.first.name!
                  : controller.storyModel.data?.first.ownerUser?.displayName != null
                      ? controller.storyModel.data!.first.ownerUser!.displayName!
                      : ''
              : '',
          maxLines: 1,
          style: const TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            // fontSize: 14,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          (controller.storyModel.data ?? []).isNotEmpty && controller.storyModel.data?.first.createdDate != null
              ? ConvertTimeComponenet.convertToAgo(controller.storyModel.data!.first.createdDate!)
              : '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: textGrey,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      // *UGC
      actions: [
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
    await bottomSheetUGC(
      onReportPost: () {
        showModalBottomSheet(
          context: Get.context!,
          builder: (context) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: ugcController.manipulatePostModel.data!.asMap().entries.map((e) {
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
                                id: controller.postId,
                                type: 'POST',
                                topic: e.value.detail ?? '',
                                message: ugcController.msgReportTextController.text,
                              );

                              Get.back(); // close dialog
                              Get.back(); // close bottom sheet

                              await 300.milliseconds.delay();
                              SnackBarComponent.show(
                                title: 'คุณได้รายงานโพสนี้แล้ว',
                                type: SnackBarType.info,
                              );
                            },
                          );
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
    );
    return;
  }
}
