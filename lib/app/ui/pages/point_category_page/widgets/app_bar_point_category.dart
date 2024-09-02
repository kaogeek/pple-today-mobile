import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/convert_image_component.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../../controllers/point_category_controller.dart';

class AppBarCategory extends GetWidget<PointCategoryController> implements PreferredSizeWidget {
  const AppBarCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      leading: const BackButton(color: Colors.white),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(88.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Obx(() {
            final categoryProducts = controller.dataModel.value.data?.categoryProducts;

            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CircleAvatar(
                    radius: context.isPhone ? 30.0 : 34.0,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: context.isPhone ? 28.0 : 32.0,
                      backgroundImage: NetworkImage(
                        (categoryProducts?.coverPageUrl ?? '').isNotEmpty
                            ? ConvertImageComponent.getImages(imageURL: categoryProducts!.coverPageUrl!)
                            : categoryProducts?.s3CoverPageUrl ?? '',
                      ),
                      child: (categoryProducts?.coverPageUrl ?? '').isEmpty
                          ? Container(
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.image_not_supported,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        (categoryProducts?.title ?? '').trim(),
                        style: TextStyle(
                          fontSize: context.isPhone ? 24 : 32,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        (categoryProducts?.title ?? '').trim(),
                        style: TextStyle(
                          fontSize: context.isPhone ? 14 : 16,
                          fontFamily: Assets.assetsFontsAnakotmaiLight,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 88.0);
}
