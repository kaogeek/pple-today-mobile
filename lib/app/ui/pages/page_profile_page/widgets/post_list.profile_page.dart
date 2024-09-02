// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../component/bottom_sheet_ugc.dart';
import '../../../../component/check_member_ship.dart';
import '../../../../component/post_card.dart';
import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/page_profile_controller.dart';
import '../../../../controllers/today_controller.dart';
import '../../../../controllers/user_generated_content_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/storage_keys.dart';

class PostListProfilePage extends StatelessWidget {
  PostListProfilePage({Key? key}) : super(key: key);

  PageProfileController controller = Get.put(PageProfileController());
  UserGeneratedContentController ugcController = Get.put(UserGeneratedContentController());
  TodayController todayController = Get.find();

  final _token = GetStorage().read(StorageKeys.token) ?? '';

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GetBuilder<PageProfileController>(
        init: PageProfileController(),
        initState: (_) {},
        builder: (controller) {
          return (controller.pagePostSearchModel.data?.posts ?? []).isEmpty
              ? Center(child: Text('ไม่มีโพสต์'))
              : Scrollbar(
                  // TODO: แก้ไขให้เลื่อนได้
                  // isAlwaysShown: true,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.pagePostSearchModel.data!.posts!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _posts = controller.pagePostSearchModel.data!.posts![index];

                      return Container(
                        padding: EdgeInsets.only(top: 8),
                        color: primaryGrey,
                        child: PostCard(
                          pageId: null,
                          postId: _posts.id ?? '',
                          typePost: _posts.type ?? 'GENERAL',
                          imageUrl: controller.pageModel.data?.imageUrl ?? '',
                          displayName: controller.pageModel.data?.name ?? '',
                          createdDate: _posts.createdDate,
                          onPressedUGC: () => _onReportBottomSheet(_posts.id ?? ''),
                          gallery: _posts.gallery ?? [],
                          titlePost: _posts.title ?? '',
                          detailPost: _posts.detail ?? '',
                          storyPost: _posts.story,
                          onPressedStory: () => _onTapReadStory(index),
                          isLike: _posts.isLike ?? false,
                          likeCount: _posts.likeCount ?? 0,
                          onPressedLike: () => _onTapLike(index),
                          isComment: false,
                          commentCount: _posts.commentCount ?? 0,
                          onPressedComment: () => _onTapComment(index),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }

  // *UGC
  Future<void> _onReportBottomSheet(String postID) async {
    await bottomSheetUGC(
      onHide: () {
        ugcController.fetchHidePost(postID);

        controller.pagePostSearchModel.data!.posts!.removeWhere(
          (element) => element.id == postID,
        );
        controller.update();

        Get.back(); // close bottom sheet

        SnackBarComponent.show(
          title: 'คุณได้ซ่อนโพสนี้แล้ว',
          type: SnackBarType.info,
        );
      },
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
                                id: postID,
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

  void _onTapReadStory(int index) {
    // TODO: implement _onTapReadStory
    // final posts = controller.pagePostSearchModel.data!.posts![index];

    // Get.to(() => StorySC(
    //       postId: posts.id!,
    //       commentCount: posts.commentCount ?? 0,
    //       repostCount: posts.repostCount ?? 0,
    //       likeCount: posts.likeCount ?? 0,
    //       shareCount: posts.shareCount ?? 0,
    //       imageUrl: controller.pageModel.data?.imageUrl ?? '',
    //       type: posts.type ?? '',
    //       createdDate: posts.createdDate!,
    //       postBy: controller.pageModel.data?.name ?? '',
    //       gallery: posts.gallery ?? [],
    //     ));
  }

  void _onTapLike(int index) {
    if (_token.isEmpty) {
      Get.toNamed(AppRoutes.LOGIN_REGISTER);
      return;
    }

    bool memberShip = CheckMemberShip().get(controller.pagePostSearchModel.data!.posts![index].type!);
    if (!memberShip) return;

    if (todayController.timerLike != null && todayController.timerLike!.isActive) return;

    controller.pagePostSearchModel.data!.posts![index].isLike =
        !controller.pagePostSearchModel.data!.posts![index].isLike!;
    controller.pagePostSearchModel.data!.posts![index].likeCount =
        controller.pagePostSearchModel.data!.posts![index].isLike!
            ? controller.pagePostSearchModel.data!.posts![index].likeCount! + 1
            : controller.pagePostSearchModel.data!.posts![index].likeCount! > 0
                ? controller.pagePostSearchModel.data!.posts![index].likeCount! - 1
                : 0;
    controller.update();

    todayController.fetchIsLike(controller.pagePostSearchModel.data!.posts![index].id!).then((value) {
      if (!value) {
        controller.pagePostSearchModel.data!.posts![index].isLike =
            !controller.pagePostSearchModel.data!.posts![index].isLike!;
        controller.pagePostSearchModel.data!.posts![index].likeCount =
            controller.pagePostSearchModel.data!.posts![index].isLike!
                ? controller.pagePostSearchModel.data!.posts![index].likeCount! + 1
                : controller.pagePostSearchModel.data!.posts![index].likeCount! > 0
                    ? controller.pagePostSearchModel.data!.posts![index].likeCount! - 1
                    : 0;
        controller.update();
      }
    });
    return;
  }

  void _onTapComment(int index) {
    if (_token.isEmpty) {
      Get.toNamed(AppRoutes.LOGIN_REGISTER);
      return;
    }

    bool memberShip = CheckMemberShip().get(controller.pagePostSearchModel.data!.posts![index].type!);
    if (!memberShip) return;

    final _post = controller.pagePostSearchModel.data!.posts![index];
    Get.toNamed(
      AppRoutes.POST_DETAIL,
      arguments: {
        'POST_ID': _post.id!,
        'FOCUS': true,
      },
    );
  }
}
