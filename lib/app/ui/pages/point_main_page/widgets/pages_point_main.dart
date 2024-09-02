import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/convert_image_component.dart';
import '../../../../controllers/point_main_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';

class PagesPointMain extends GetWidget<PointMainController> {
  const PagesPointMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = controller.pointContentModel.value.data;

      return (data?.categoryProduct ?? []).isEmpty
          ? const SizedBox()
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: data!.categoryProduct!.map((category) {
                    return Container(
                      width: context.isPhone ? 100.0 : 140.0,
                      margin: EdgeInsets.only(right: context.isPhone ? 16.0 : 24.0),
                      child: Column(
                        children: [
                          _buildImagePage(
                            categoryId: category.id ?? '',
                            imageUrl: category.coverPageUrl != null || category.coverPageUrl!.isNotEmpty
                                ? ConvertImageComponent.getImages(imageURL: category.coverPageUrl!)
                                : category.s3CoverPageUrl ?? '',
                          ),
                          Text(
                            (category.title ?? '').trim(),
                            style: TextStyle(
                              fontSize: context.isPhone ? 14 : 20,
                              fontFamily: Assets.assetsFontsAnakotmaiLight,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
    });
  }

  Widget _buildImagePage({
    required String categoryId,
    required String imageUrl,
  }) {
    BuildContext context = Get.context!;

    return GestureDetector(
      onTap: () {
        if (categoryId.isNotEmpty) {
          Get.toNamed(
            AppRoutes.POINT_CATEGORY,
            parameters: {'categoryId': categoryId},
          );
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(300.0),
        child: Image.network(
          imageUrl,
          height: context.isPhone ? 80.0 : 120.0,
          width: context.isPhone ? 80.0 : 120.0,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: context.isPhone ? 80.0 : 120.0,
              height: context.isPhone ? 80.0 : 120.0,
              color: Colors.grey,
              child: const Center(
                child: Icon(
                  Icons.image,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
