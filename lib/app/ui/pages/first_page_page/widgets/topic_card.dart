import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/first_page_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';

class TopicCard extends GetWidget<FirstPageController> {
  const TopicCard({super.key});

  @override
  Widget build(BuildContext context) {
    final _sizeCardWidth = Get.width;
    final _sizecardHeight = context.isPhone ? 480.0 : 720.0;
    final _sizeTextTitle = context.isPhone ? 56.0 : 80.0;
    final _sizeTextDate = context.isPhone ? 24.0 : 40.0;
    final _sizedBGTextDate = context.isPhone ? 48.0 : 64.0;

    return Obx(() {
      if (controller.firstPageModel.value.data?.today == null) return const SizedBox();

      return GestureDetector(
        onTap: () {
          Get.toNamed(
            AppRoutes.DETAIL_FIRST,
            arguments: {
              'TIME_STAMP': controller.firstPageModel.value.data!.today!.timeStamp!,
              // 'DATE': controller.firstPageModel.value.data!.today!.date!,
            },
          );
        },
        child: Stack(
          children: [
            /// Background Image
            Container(
              width: _sizeCardWidth,
              height: _sizecardHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2),
                    BlendMode.colorBurn,
                  ),
                  image: NetworkImage(controller.firstPageModel.value.data!.today!.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// Content
            SizedBox(
              width: _sizeCardWidth,
              height: _sizecardHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Title
                  Text(
                    controller.firstPageModel.value.data!.today!.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _sizeTextTitle,
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 16,
                          offset: const Offset(2.0, 0.0),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  /// Date
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    width: double.infinity,
                    height: _sizedBGTextDate,
                    child: Center(
                      child: Text(
                        controller.firstPageModel.value.data!.today!.date!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _sizeTextDate,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
