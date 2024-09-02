import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_detail_controller.dart';
import '../../../../controllers/slider_show_image_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';

class CoverImage extends GetWidget<MfpVoteDetailController> {
  const CoverImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _heightImage = context.isPhone ? 422 : 622;
    final double _widthImage = Get.width;

    return GestureDetector(
      onTap: () {
        if (controller.voteImage.isNotEmpty) {
          Get.toNamed(
            AppRoutes.SLIDER_SHOW_IMAGE,
            arguments: SliderShowImageArguments(galleryList: [controller.voteImage]),
          );
        }
      },
      child: controller.voteImage.isEmpty
          ? Image.asset(
              'assets/images/vote_0${controller.number}.jpg',
              height: _heightImage,
              width: _widthImage,
              fit: BoxFit.cover,
            )
          : Image.network(
              controller.voteImage,
              height: _heightImage,
              width: _widthImage,
              // fit: BoxFit.fitWidth,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  height: _heightImage,
                  width: _widthImage,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                      value: loadingProgress.expectedTotalBytes == null ? null : loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/vote_0${controller.number}.jpg',
                  height: 422,
                  width: Get.width,
                  fit: BoxFit.cover,
                );
              },
            ),
    );
  }
}
