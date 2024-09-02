// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/today_recommend_controller.dart';
import '../../../../data/models/recommend_user_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/storage_keys.dart';

class TodayRecommendedUser extends GetWidget<TodayRecommendController> {
  final RecommendUserModel recommend;

  const TodayRecommendedUser({Key? key, required this.recommend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.setData(recommend);

    return (recommend.data ?? []).isEmpty
        ? const SizedBox()
        : Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'แนะนำให้ติดตาม',
                  style: TextStyle(
                    fontSize: 24,
                    color: primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(thickness: 1),
              Obx(() => ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemCount: controller.recommend.value.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _data = controller.recommend.value.data![index];

                      return _buildCard(
                        index: index,
                        imageUrl: _data.imageUrl ?? '',
                        displayName: _data.displayName ?? _data.name ?? '',
                        pageUsername: _data.pageUsername ?? '',
                        isFollow: _data.isFollow ?? false,
                        type: _data.type ?? '',
                        pageId: _data.id ?? '',
                      );
                    },
                  )),
              const SizedBox(height: 16),
            ],
          );
  }

  Widget _buildCard({
    required int index,
    required String imageUrl,
    required String displayName,
    required String pageUsername,
    required bool isFollow,
    required String type,
    required String pageId,
  }) {
    return SizedBox(
      height: 88,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: GestureDetector(
            onTap: () {
              if ((type.toUpperCase() == 'PAGE') && (pageId.isNotEmpty)) {
                Get.toNamed(
                  AppRoutes.PAGE_PROFILE,
                  arguments: {'PAGE_ID': pageId},
                );
              }
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: imageUrl.isEmpty
                        ? Image.asset(
                            Assets.assetsImagesPlaceholderPerson,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                Assets.assetsImagesPlaceholderPerson,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        pageUsername.isNotEmpty
                            ? Text(
                                pageUsername,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: textGrey,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 36,
                  width: 95,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        side: BorderSide(color: kPrimaryColor),
                      ),
                      primary: isFollow ? kPrimaryColor : Colors.white,
                    ),
                    onPressed: () {
                      _onTapFollow(index);
                    },
                    child: AutoSizeText(
                      isFollow ? 'เลิกติดตาม' : 'ติดตาม',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        color: isFollow ? Colors.white : kPrimaryColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapFollow(int index) {
    String token = GetStorage().read(StorageKeys.token) ?? '';

    if (token.isEmpty) {
      Get.toNamed(AppRoutes.LOGIN_REGISTER);
      return;
    }

    String type = controller.recommend.value.data![index].type!;
    String pageId = controller.recommend.value.data![index].id!;
    String name = controller.recommend.value.data![index].displayName ?? controller.recommend.value.data![index].name!;

    controller.fetchFollowed(pageId: pageId, type: type);

    controller.recommend.value.data![index].isFollow = !(controller.recommend.value.data![index].isFollow ?? false);
    controller.recommend.refresh();

    if (controller.recommend.value.data![index].isFollow!) {
      SnackBarComponent.show(
        title: 'ติดตามสำเร็จ',
        message: 'คุณได้ทำการติดตาม $name เรียบร้อยแล้ว',
        type: SnackBarType.success,
      );
    }

    return;
  }
}
