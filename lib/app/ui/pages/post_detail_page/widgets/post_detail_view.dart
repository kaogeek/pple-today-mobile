// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/album_card.dart';
import '../../../../controllers/post_detail_controller.dart';
import '../../../../controllers/slider_show_image_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class PostDetailView extends StatelessWidget {
  PostDetailView({super.key});

  PostDetailController controller = Get.put(PostDetailController());

  @override
  Widget build(BuildContext context) {
    final data = controller.storyModel.data!.first;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((data.gallery ?? []).isNotEmpty)
            AlbumCard(
              gallery: data.gallery!,
              onTap: () {
                Get.toNamed(
                  AppRoutes.SLIDER_SHOW_IMAGE,
                  arguments: SliderShowImageArguments(galleryList: data.gallery!),
                );
              },
            ),
          Padding(
            padding: EdgeInsets.only(
              left: 8,
              top: (data.gallery ?? []).isEmpty ? 0 : 20,
            ),
            child: Text(
              data.title ?? '',
              style: TextStyle(
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                fontSize: (data.gallery ?? []).isEmpty ? 25 : 17,
                color: primaryBlue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Text(
              data.detail ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          data.story == null
              ? const SizedBox()
              : TextButton(
                  onPressed: _onTapReadStory,
                  child: const Text(
                    'อ่านสตอรี่...',
                    style: TextStyle(
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      fontSize: 14,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _onTapReadStory() {
    // TODO: implement _onTapReadStory
    // final data = controller.storyModel.data!.first;

    // if (data.page == null || (data.page ?? []).isNotEmpty) {
    //   Get.to(() => StorySC(
    //         postId: postId,
    //         commentCount: data.commentCount ?? 0,
    //         repostCount: data.repostCount ?? 0,
    //         likeCount: data.likeCount ?? 0,
    //         shareCount: data.shareCount ?? 0,
    //         imageUrl: data.gallery?[0].imageUrl ?? '',
    //         type: type,
    //         createdDate: data.createdDate!,
    //         postBy: data.page?[0].name ?? '',
    //         gallery: data.gallery ?? [],
    //       ));
    // }
  }
}
