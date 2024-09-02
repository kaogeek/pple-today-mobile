import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/first_page_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';

class PopularNews extends GetWidget<FirstPageController> {
  const PopularNews({super.key});

  @override
  Widget build(BuildContext context) {
    final _sizeCardWidth = context.isPhone ? 280.0 : 400.0;
    final _sizeCardHeight = context.isPhone ? 400.0 : 560.0;
    final _sizeTextTopic = context.isPhone ? 24.0 : 32.0;
    final _sizeTextTitle = context.isPhone ? 36.0 : 56.0;
    final _sizeTextDate = context.isPhone ? 16.0 : 24.0;
    final _sizedBGTextDate = context.isPhone ? 48.0 : 64.0;

    return Obx(() {
      if ((controller.firstPageModel.value.data?.popularNews ?? []).isEmpty) return const SizedBox();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32.0),
          Text(
            'ยอดฮิต',
            style: TextStyle(
              color: Colors.black,
              fontSize: _sizeTextTopic,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...controller.firstPageModel.value.data!.popularNews!.map(
                  (e) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.DETAIL_FIRST,
                            arguments: {
                              'TIME_STAMP': e.timeStamp!,
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            /// Background Image
                            Container(
                              width: _sizeCardWidth,
                              height: _sizeCardHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.colorBurn,
                                  ),
                                  image: NetworkImage(e.image!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            /// Content
                            SizedBox(
                              width: _sizeCardWidth,
                              height: _sizeCardHeight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// Title
                                  Text(
                                    e.title!,
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
                                        e.date!,
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
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
