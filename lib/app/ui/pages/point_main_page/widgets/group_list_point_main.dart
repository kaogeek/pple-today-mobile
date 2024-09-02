import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../component/convert_image_component.dart';
import '../../../../controllers/point_main_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class GroupListPointMain extends GetWidget<PointMainController> {
  const GroupListPointMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final productAggr = controller.pointContentModel.value.data?.productAggr;

      return (productAggr ?? []).isEmpty
          ? const SizedBox()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.pointContentModel.value.data!.productAggr!.map((e) {
                return Container(
                  padding: EdgeInsets.only(top: context.isPhone ? 32.0 : 40.0),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                (e.title ?? '').trim(),
                                style: TextStyle(
                                  fontSize: context.isPhone ? 24 : 32,
                                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if ((e.id ?? '').isNotEmpty) {
                                  Get.toNamed(
                                    AppRoutes.POINT_CATEGORY,
                                    parameters: {'categoryId': e.id!},
                                  );
                                }
                              },
                              child: Text(
                                'ดูทั้งหมด',
                                style: TextStyle(
                                  fontSize: context.isPhone ? 16 : 24,
                                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                  color: kPrimaryColor,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: (e.product ?? []).map((post) {
                              return _buildCardPost((e.title ?? '').trim(), post);
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
    });
  }

  Widget _buildCardPost(String categoryName, dynamic post) {
    BuildContext context = Get.context!;

    return Padding(
      padding: EdgeInsets.only(
        right: context.isPhone ? 8.0 : 16.0,
        bottom: 16.0,
      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            AppRoutes.POINT_PRODUCT_DETAIL,
            parameters: {'pointProductId': post.id!},
          )?.then(
            (value) {
              if (value ?? false) {
                500.milliseconds.delay(() => controller.confettiController.play());

                controller.pointContentModel.update((val) {
                  for (var element1 in val!.data!.productAggr!) {
                    if (element1.title == categoryName) {
                      debugPrint('CATEGORY_NAME: ${element1.title}', wrapWidth: 1024);
                      for (var element2 in element1.product!) {
                        if ((element2.id == post.id)) {
                          debugPrint('ID: ${element2.id}', wrapWidth: 1024);
                          element2.receiverCoupon = (element2.receiverCoupon ?? 0) + 1;
                          debugPrint('RECEIVER_COUPON: ${element2.receiverCoupon}', wrapWidth: 1024);
                        }
                      }
                    }
                  }
                });
              }
            },
          );
        },
        child: Card(
          child: Container(
            width: context.isPhone ? 200.0 : 320.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(8, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: context.isPhone ? 200.0 : 320.0,
                  width: context.isPhone ? 200.0 : 320.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Image.network(
                          post.coverPageUrl != null || post.coverPageUrl!.isNotEmpty ? ConvertImageComponent.getImages(imageURL: post.coverPageUrl!) : post.s3CoverPageUrl ?? '',
                          height: context.isPhone ? 200.0 : 320.0,
                          width: context.isPhone ? 200.0 : 320.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: context.isPhone ? 200.0 : 320.0,
                              height: context.isPhone ? 200.0 : 320.0,
                              color: Colors.grey,
                              child: const Center(
                                child: Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: 32.0,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                _buildTextTitle(post.title),
                Divider(
                  color: Colors.grey.shade200,
                ),
                _buildPoint(post.point),
                _buildProgressBar(post.receiverCoupon, post.maximumLimit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextTitle(String title) {
    BuildContext context = Get.context!;

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(context.isPhone ? 8.0 : 16.0),
        child: Text(
          '$title\n',
          maxLines: 2,
          style: TextStyle(
            fontSize: context.isPhone ? 16 : 24,
            fontFamily: Assets.assetsFontsAnakotmaiMedium,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildPoint(int point) {
    BuildContext context = Get.context!;

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.isPhone ? 8.0 : 16.0, vertical: 8.0),
          child: Image.asset(
            Assets.assetsImagesPoint,
            width: context.isPhone ? 16.0 : 24.0,
            height: context.isPhone ? 16.0 : 24.0,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Text(
            NumberFormat("#,###").format(point),
            style: TextStyle(
              fontSize: context.isPhone ? 16 : 24,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(int receiver, int maximum) {
    BuildContext context = Get.context!;

    return Padding(
      padding: EdgeInsets.all(context.isPhone ? 8.0 : 16.0),
      child: Stack(
        children: [
          SizedBox(
            height: context.isPhone ? 16.0 : 24.0,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              child: LinearProgressIndicator(
                value: 1.0 - (receiver / maximum),
                backgroundColor: Colors.grey.shade400,
                valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'เหลือ\t'
              '${maximum - receiver}',
              style: TextStyle(
                fontSize: context.isPhone ? 12 : 18,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
