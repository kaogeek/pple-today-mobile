// ignore_for_file: must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../component/convert_time_componenet.dart';
import '../../../../component/read_more_text.dart';
import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/post_detail_controller.dart';
import '../../../../controllers/today_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/enum.dart';
import '../../../utils/storage_keys.dart';

class PostDetailCommentView extends StatelessWidget {
  PostDetailCommentView({Key? key}) : super(key: key);

  PostDetailController controller = Get.put(PostDetailController());
  TodayController todayController = Get.put(TodayController());

  final _uid = GetStorage().read(StorageKeys.uid) ?? '';

  @override
  Widget build(BuildContext context) {
    return (controller.commentListModel.data ?? []).isEmpty
        ? const SizedBox()
        : Container(
            color: Colors.grey.shade100,
            padding: const EdgeInsets.only(top: 8),
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              itemCount: controller.commentListModel.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final _data = controller.commentListModel.data![index];

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                            child: (_data.user?.imageUrl ?? '').isEmpty
                                ? CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(
                                      Assets.assetsImagesPlaceholderPerson,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(_data.user!.imageUrl!),
                                  ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: Container(
                                  width: Get.width - 90,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffDEDEDE),
                                    ),
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4, top: 4),
                                          child: Text(
                                            _data.user?.displayName ?? '',
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 12,
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                              color: primaryBlue,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4, bottom: 4),
                                          child: ReadMoreText(
                                            _data.comment ?? '',
                                            trimMode: TrimMode.line,
                                            style: TextStyle(
                                              fontSize: 14,
                                              // fontWeight: FontWeight.w500,
                                              fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                child: Row(
                                  children: [
                                    const SizedBox(width: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: GestureDetector(
                                        onTap: () => onTapLike(index),
                                        child: Text(
                                          '${_data.likeCount ?? 0} ถูกใจ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: _data.isLike ?? false ? kPrimaryColor : primaryBlue,
                                          ),
                                        ),
                                      ),
                                    ),
                                    (_data.user?.id ?? '') != _uid
                                        ? const SizedBox()
                                        : Padding(
                                            padding: const EdgeInsets.only(right: 16),
                                            child: GestureDetector(
                                              onTap: () => onTapDeleteComment(index),
                                              child: const Text(
                                                'ลบ',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryBlue,
                                                ),
                                              ),
                                            ),
                                          ),
                                    (_data.user?.id ?? '') != _uid
                                        ? const SizedBox()
                                        : Padding(
                                            padding: const EdgeInsets.only(right: 16),
                                            child: GestureDetector(
                                              onTap: () => onTapEdit(index),
                                              child: const Text(
                                                'แก้ไข',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryBlue,
                                                ),
                                              ),
                                            ),
                                          ),
                                    Text(
                                      _data.createdDate == null
                                          ? ''
                                          : ConvertTimeComponenet.convertToAgo(_data.createdDate!),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontSize: 12,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ((controller.storyModel.data!.first.commentCount ?? 0) > 5) &&
                            (index == controller.commentListModel.data!.length - 1)
                        ? controller.isNotComment
                            ? const SafeArea(child: SizedBox())
                            : controller.isLoadMore
                                ? const CircularProgressIndicator(color: kPrimaryColor)
                                : Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 68),
                                      child: TextButton(
                                        onPressed: () async {
                                          controller.isLoadMore = true;
                                          controller.update();

                                          await controller.fetchCommentList(
                                            controller.postId,
                                            offset: controller.commentListModel.data!.length,
                                          );

                                          controller.isLoadMore = false;
                                          controller.update();
                                        },
                                        child: const Text(
                                          'ดูความคิดเห็นเพิ่มเติม',
                                          style: TextStyle(color: kPrimaryColor),
                                        ),
                                      ),
                                    ),
                                  )
                        : const SizedBox(),
                  ],
                );
              },
            ),
          );
  }

  void onTapLike(int index) {
    String token = GetStorage().read(StorageKeys.token) ?? '';

    if (token.isEmpty) {
      Get.toNamed(AppRoutes.LOGIN_REGISTER);
      return;
    }

    // bool memberShip = CheckMemberShip().get( controller.commentListModel.data![index].type!);
    // if (!memberShip) return;

    controller.commentListModel.data![index].isLike = !(controller.commentListModel.data![index].isLike ?? false);
    controller.commentListModel.data![index].likeCount = controller.commentListModel.data![index].isLike!
        ? (controller.commentListModel.data![index].likeCount ?? 0) + 1
        : (controller.commentListModel.data![index].likeCount ?? 0) > 0
            ? (controller.commentListModel.data![index].likeCount ?? 0) - 1
            : 0;
    controller.update();

    controller.fetchIsLikeComment(
      postId: controller.postId,
      commentId: controller.commentListModel.data![index].id!,
    );

    return;
  }

  Future<void> onTapDeleteComment(int index) async {
    final _data = controller.commentListModel.data![index];

    await Get.defaultDialog(
      title: 'ลบความคิดเห็น',
      content: Text(
        'คุณต้องการลดความคิดเห็น ใช่หรือไม่',
        style: TextStyle(
          fontFamily: Assets.assetsFontsAnakotmaiLight,
        ),
      ),
      textConfirm: 'ลบ',
      textCancel: 'ยกเลิก',
      confirmTextColor: kPrimaryColor,
      cancelTextColor: kPrimaryColor,
      buttonColor: Colors.white,
      onConfirm: () async {
        controller.commentListModel.data!.removeWhere((element) => element.id == _data.id);
        controller.storyModel.data!.first.commentCount = controller.storyModel.data!.first.commentCount! - 1;
        controller.update();

        todayController.postStoryModel.data!.forEach((element) {
          if (element.post!.id == controller.postId) {
            if ((element.post!.commentCount ?? 0) > 0) {
              element.post!.commentCount = element.post!.commentCount! - 1;
              todayController.update();
            }
          }
        });

        Get.back();

        300.milliseconds.delay(() {
          SnackBarComponent.show(
            title: 'ลบความคิดเห็นสำเร็จ',
            type: SnackBarType.success,
          );
        });

        await controller.fetchDeleteComment(
          postId: controller.postId,
          commentId: _data.id!,
        );

        todayController.fetchStory(controller.postId);
        todayController.fetchPostStory();
        return;
      },
    );
    return;
  }

  void onTapEdit(int index) {
    final _data = controller.commentListModel.data![index];

    controller.isEdit = true;
    controller.commentId = _data.id!;
    controller.commentTextController.clear();
    controller.commentTextController.text = _data.comment!;
    controller.focusNode.requestFocus();
    controller.update();
  }
}
