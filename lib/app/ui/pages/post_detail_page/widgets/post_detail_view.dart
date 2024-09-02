// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mfp_app/app/controllers/slider_show_image_controller.dart';

import '../../../../component/album_card.dart';
import '../../../../controllers/post_detail_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class PostDetailView extends StatelessWidget {
  PostDetailView({Key? key}) : super(key: key);

  PostDetailController controller = Get.put(PostDetailController());

  @override
  Widget build(BuildContext context) {
    final _data = controller.storyModel.data!.first;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((_data.gallery ?? []).isNotEmpty)
            AlbumCard(
              gallery: _data.gallery!,
              onTap: () {
                Get.toNamed(
                  AppRoutes.SLIDER_SHOW_IMAGE,
                  arguments: SliderShowImageArguments(galleryList: _data.gallery!),
                );
              },
            ),
          Padding(
            padding: EdgeInsets.only(
              left: 8,
              top: (_data.gallery ?? []).isEmpty ? 0 : 20,
            ),
            child: Text(
              _data.title ?? '',
              style: TextStyle(
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                fontSize: (_data.gallery ?? []).isEmpty ? 25 : 17,
                color: primaryBlue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Text(
              _data.detail ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          _data.story == null
              ? const SizedBox()
              : TextButton(
                  onPressed: _onTapReadStory,
                  child: Text(
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
