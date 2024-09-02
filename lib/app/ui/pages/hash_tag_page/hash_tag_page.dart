import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/hash_tag_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import 'widgets/card_post.dart';

class HashTagPage extends GetView<HashTagController> {
  const HashTagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller.emerTag.isNotEmpty)
              SvgPicture.asset(
                Assets.assetsImagesEvent,
                color: Colors.grey,
              ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 60),
              child: Text(
                '#'
                '${controller.emerTag.isNotEmpty ? controller.emerTag : controller.hashTag}',
                style: Get.theme.textTheme.headline6!.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
          future: controller.emerTag.isNotEmpty ? controller.fetchEmerTagId() : controller.fetchHashTagPost(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              );
            }

            return RefreshIndicator(
              onRefresh: controller.onRefresh,
              color: kPrimaryColor,
              child: GetBuilder<HashTagController>(
                init: HashTagController(),
                initState: (_) {},
                builder: (_) {
                  if ((controller.hashTagPostModel.data ?? []).isEmpty) {
                    return Center(
                      child: Text(
                        'ไม่พบข้อมูล',
                        style: Get.theme.textTheme.headline6!.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.hashTagPostModel.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0 && controller.emerTag.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                '#'
                                '${controller.hashTag}',
                                style: Get.theme.textTheme.headline4!.copyWith(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                ),
                              ),
                            ),
                          CardPost(index),
                          // if (controller.isNotPostStory)
                          //   const Padding(
                          //     padding: EdgeInsets.all(8),
                          //     child: Center(
                          //       child: Text(
                          //         'ไม่มีโพสต์',
                          //         style: TextStyle(
                          //           fontSize: 18,
                          //           color: textDark,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          if ((index == controller.hashTagPostModel.data!.length - 1) && controller.isLoadMore)
                            const Padding(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              ),
                            )
                        ],
                      );
                    },
                  );
                },
              ),
            );
          }),
    );
  }
}
