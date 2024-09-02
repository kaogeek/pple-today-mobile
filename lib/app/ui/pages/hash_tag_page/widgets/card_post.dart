import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../component/bottom_sheet_ugc.dart';
import '../../../../component/button_social.dart';
import '../../../../component/check_member_ship.dart';
import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/hash_tag_controller.dart';
import '../../../../controllers/today_controller.dart';
import '../../../../controllers/user_generated_content_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/environment.dart';
import '../../../utils/storage_keys.dart';
import 'detail_text_post.dart';
import 'image_post.dart';
import 'profile_post.dart';
import 'title_text_post.dart';

class CardPost extends GetView<HashTagController> {
  final int index;

  CardPost(this.index, {Key? key}) : super(key: key);

  final _todayController = Get.put(TodayController());
  final _ugcController = Get.put(UserGeneratedContentController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: (index == controller.hashTagPostModel.data!.length - 1),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey.shade200,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfilePost(
                index,
                onPressedUGC: _onReportBottomSheet,
              ),
              GestureDetector(
                onTap: () {
                  String? postId = controller.hashTagPostModel.data![index].post!.id ?? '';
                  if (postId.isNotEmpty) {
                    Get.toNamed(
                      AppRoutes.POST_DETAIL,
                      arguments: {
                        'POST_ID': postId,
                        'FOCUS': false,
                      },
                    );
                    return;
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImagePost(index),
                    TitleTextPost(index),
                    DetailTextPost(index),
                  ],
                ),
              ),
              ButtonSocial(
                isLike: controller.hashTagPostModel.data![index].post!.isLike ?? false,
                likeCount: controller.hashTagPostModel.data![index].post!.likeCount ?? 0,
                onTapLike: _onTapLike,
                isComment: false,
                commentCount: controller.hashTagPostModel.data![index].post!.commentCount ?? 0,
                onTapComment: _onTapComment,
                urlShare: '${Environment.domainName}/post/${controller.hashTagPostModel.data![index].post!.id}',
              ),
              const SizedBox(height: 2),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onReportBottomSheet() async {
    final _data = controller.hashTagPostModel.data![index];

    await bottomSheetUGC(
      onHide: () {
        _ugcController.fetchHidePost(_data.post!.id!);

        controller.hashTagPostModel.data!.removeWhere(
          (element) => element.post!.id == _data.post!.id!,
        );
        controller.update();

        Get.back(); // close bottom sheet

        SnackBarComponent.show(
          title: 'คุณได้ซ่อนโพสนี้แล้ว',
          type: SnackBarType.info,
        );
      },
      onReportPost: ((_ugcController.manipulatePostModel.data ?? []).isEmpty)
          ? null
          : () {
              showModalBottomSheet(
                context: Get.context!,
                builder: (context) {
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _ugcController.manipulatePostModel.data!.asMap().entries.map((e) {
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
                                    controller: _ugcController.msgReportTextController,
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
                                    _ugcController.fetchReportPostPageUser(
                                      id: _data.post!.id!,
                                      type: 'POST',
                                      topic: e.value.detail ?? '',
                                      message: _ugcController.msgReportTextController.text,
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
      onBlock: () async {
        String pageId = _data.post!.page?.id ?? _data.post!.pageId ?? '';
        String pageName = _data.post!.page?.name ?? '';

        _ugcController.fetchBlockPageUser(
          id: pageId,
          type: 'PAGE',
        );

        controller.hashTagPostModel.data!.removeWhere(
          (element) => (element.post!.page?.id == pageId) || (element.post!.pageId == pageId),
        );
        controller.update();

        Get.back(); // close bottom sheet

        await 300.milliseconds.delay();
        SnackBarComponent.show(
          title: 'คุณได้บล็อคเพจ\n$pageName แล้ว',
          type: SnackBarType.info,
        );
      },
    );

    return;
  }

  void _onTapLike() {
    final _token = GetStorage().read(StorageKeys.token) ?? '';

    if (_token.isEmpty) {
      Get.toNamed(AppRoutes.LOGIN_REGISTER);
      return;
    }

    bool memberShip = CheckMemberShip().get(controller.hashTagPostModel.data![index].post!.type!);
    if (!memberShip) return;

    if (_todayController.timerLike != null && _todayController.timerLike!.isActive) return;

    controller.hashTagPostModel.data![index].post!.isLike = !controller.hashTagPostModel.data![index].post!.isLike!;
    controller.hashTagPostModel.data![index].post!.likeCount = controller.hashTagPostModel.data![index].post!.isLike!
        ? controller.hashTagPostModel.data![index].post!.likeCount! + 1
        : controller.hashTagPostModel.data![index].post!.likeCount! > 0
            ? controller.hashTagPostModel.data![index].post!.likeCount! - 1
            : 0;
    controller.update();

    _todayController.fetchIsLike(controller.hashTagPostModel.data![index].post!.id!).then((value) {
      if (!value) {
        controller.hashTagPostModel.data![index].post!.isLike = !controller.hashTagPostModel.data![index].post!.isLike!;
        controller.hashTagPostModel.data![index].post!.likeCount =
            controller.hashTagPostModel.data![index].post!.isLike!
                ? controller.hashTagPostModel.data![index].post!.likeCount! + 1
                : controller.hashTagPostModel.data![index].post!.likeCount! > 0
                    ? controller.hashTagPostModel.data![index].post!.likeCount! - 1
                    : 0;
        controller.update();
      }
    });

    return;
  }

  void _onTapComment() {
    final _token = GetStorage().read(StorageKeys.token) ?? '';

    if (_token.isEmpty) {
      Get.toNamed(AppRoutes.LOGIN_REGISTER);
      return;
    }

    bool memberShip = CheckMemberShip().get(controller.hashTagPostModel.data![index].post!.type!);
    if (!memberShip) return;

    final _data = controller.hashTagPostModel.data![index];

    Get.toNamed(
      AppRoutes.POST_DETAIL,
      arguments: {
        'POST_ID': _data.post!.id!,
        'FOCUS': true,
      },
    );
    return;
  }
}
