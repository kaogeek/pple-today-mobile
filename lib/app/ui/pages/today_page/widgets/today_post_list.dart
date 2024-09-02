// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../component/bottom_sheet_ugc.dart';
import '../../../../component/check_member_ship.dart';
import '../../../../component/post_card.dart';
import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/today_controller.dart';
import '../../../../controllers/user_generated_content_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/storage_keys.dart';

class TodayPostList extends StatelessWidget {
  final int index;

  TodayPostList(this.index, {Key? key}) : super(key: key);

  TodayController controller = Get.put(TodayController());
  UserGeneratedContentController ugcController = Get.put(UserGeneratedContentController());

  final _token = GetStorage().read(StorageKeys.token) ?? '';

  @override
  Widget build(BuildContext context) {
    final _data = controller.postStoryModel.data![index];

    return PostCard(
      key: key,
      pageId: _data.post!.page?.id ?? _data.post!.pageId!,
      postId: _data.post!.id!,
      typePost: _data.post!.type ?? 'GENERAL',
      imageUrl: _data.post!.page?.imageUrl ?? '',
      displayName: _data.post!.page?.name ?? _data.user?.displayName ?? '',
      createdDate: _data.post!.createdDate,
      onPressedUGC: _onReportBottomSheet,
      gallery: _data.post!.gallery ?? [],
      titlePost: _data.post!.title ?? '',
      detailPost: _data.post!.detail ?? '',
      storyPost: _data.post!.story,
      onPressedStory: _onTapReadStory,
      isLike: _data.post!.isLike ?? false,
      likeCount: _data.post!.likeCount ?? 0,
      onPressedLike: _onTapLike,
      isComment: false,
      commentCount: _data.post!.commentCount ?? 0,
      onPressedComment: _onTapComment,
    );
  }

  // *UGC
  Future<void> _onReportBottomSheet() async {
    final _data = controller.postStoryModel.data![index];

    await bottomSheetUGC(
      onHide: () {
        ugcController.fetchHidePost(_data.post!.id!);

        controller.postStoryModel.data!.removeWhere(
          (element) => element.post!.id == _data.post!.id!,
        );
        controller.update();

        Get.back(); // close bottom sheet

        SnackBarComponent.show(
          title: 'คุณได้ซ่อนโพสนี้แล้ว',
          type: SnackBarType.info,
        );
      },
      onReportPost: ((ugcController.manipulatePostModel.data ?? []).isEmpty)
          ? null
          : () {
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
                                      id: _data.post!.id!,
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
      onBlock: () async {
        String pageId = _data.post!.page?.id ?? _data.post!.pageId ?? '';
        String pageName = _data.post!.page?.name ?? '';

        ugcController.fetchBlockPageUser(
          id: pageId,
          type: 'PAGE',
        );

        controller.postStoryModel.data!.removeWhere(
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

  void _onTapReadStory() {
    // TODO: implement _onTapReadStory
    /* final data = controller.postStoryModel.data![index];

    Get.to(() => StorySC(
          postId: data.post!.id!,
          commentCount: data.post?.commentCount ?? 0,
          repostCount: data.post?.repostCount ?? 0,
          likeCount: data.post?.likeCount ?? 0,
          shareCount: data.post?.shareCount ?? 0,
          imageUrl: data.post?.page?.imageUrl ?? '',
          type: data.post?.type ?? '',
          createdDate: data.post!.createdDate!,
          postBy: data.post?.page?.name ?? '',
          gallery: data.post?.gallery ?? [],
        ));
     */
  }

  void _onTapLike() {
    if (_token.isEmpty) {
      Get.toNamed(AppRoutes.LOGIN_REGISTER);
      return;
    }

    bool memberShip = CheckMemberShip().get(controller.postStoryModel.data![index].post!.type!);
    if (!memberShip) return;

    if (controller.timerLike != null && controller.timerLike!.isActive) return;

    controller.postStoryModel.data![index].post!.isLike = !controller.postStoryModel.data![index].post!.isLike!;
    controller.postStoryModel.data![index].post!.likeCount = controller.postStoryModel.data![index].post!.isLike!
        ? controller.postStoryModel.data![index].post!.likeCount! + 1
        : controller.postStoryModel.data![index].post!.likeCount! > 0
            ? controller.postStoryModel.data![index].post!.likeCount! - 1
            : 0;
    controller.update();

    controller.fetchIsLike(controller.postStoryModel.data![index].post!.id!).then((value) {
      if (!value) {
        controller.postStoryModel.data![index].post!.isLike = !controller.postStoryModel.data![index].post!.isLike!;
        controller.postStoryModel.data![index].post!.likeCount = controller.postStoryModel.data![index].post!.isLike!
            ? controller.postStoryModel.data![index].post!.likeCount! + 1
            : controller.postStoryModel.data![index].post!.likeCount! > 0
                ? controller.postStoryModel.data![index].post!.likeCount! - 1
                : 0;
        controller.update();
      }
    });

    return;
  }

  void _onTapComment() {
    if (_token.isEmpty) {
      Get.toNamed(AppRoutes.LOGIN_REGISTER);
      return;
    }

    bool memberShip = CheckMemberShip().get(controller.postStoryModel.data![index].post!.type!);
    if (!memberShip) return;

    final _data = controller.postStoryModel.data![index];
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
