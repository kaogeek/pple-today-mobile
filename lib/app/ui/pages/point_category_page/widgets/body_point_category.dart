import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../component/convert_image_component.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../../controllers/point_category_controller.dart';
import '../../../../routes/app_routes.dart';

class BodyPointCategory extends GetWidget<PointCategoryController> {
  const BodyPointCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final products = controller.dataModel.value.data?.categoryProducts?.product;

      if ((products ?? []).isEmpty) {
        return Center(
          child: Text(
            'ไม่พบข้อมูล',
            style: TextStyle(
              fontSize: context.isPhone ? 24 : 32,
              fontFamily: Assets.assetsFontsAnakotmaiLight,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: context.isPhone ? 0.0 : 4.0,
            runSpacing: context.isPhone ? 8.0 : 16.0,
            children: products!.map((post) {
              return _buildCardPost(post);
            }).toList(),
          ),
        ),
      );
    });
  }

  Widget _buildCardPost(dynamic post) {
    BuildContext context = Get.context!;

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.POINT_PRODUCT_DETAIL,
          parameters: {'pointProductId': post.id!},
        );
      },
      child: Card(
        child: Container(
          width: context.isPhone ? (context.width / 2) - 16.0 : (context.width / 3) - 16.0,
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
                width: context.isPhone ? (context.width / 2) - 16.0 : (context.width / 3) - 16.0,
                height: context.isPhone ? (context.width / 2) - 16.0 : (context.width / 3) - 16.0,
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
                        width: context.isPhone ? (context.width / 2) - 16.0 : (context.width / 3) - 16.0,
                        height: context.isPhone ? (context.width / 2) - 16.0 : (context.width / 3) - 16.0,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: context.isPhone ? (context.width / 2) - 16.0 : (context.width / 3) - 16.0,
                            height: context.isPhone ? (context.width / 2) - 16.0 : (context.width / 3) - 16.0,
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
    );
  }

  Widget _buildInfo(int point, int vdoMeet) {
    BuildContext context = Get.context!;

    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        height: context.isPhone ? 72.0 : 102.0,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'แลก',
                        style: TextStyle(
                          fontSize: context.isPhone ? 12 : 16,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: AutoSizeText(
                        NumberFormat("#,###").format(point),
                        presetFontSizes: context.isPhone
                            ? [28.0, 24.0, 22.0, 20.0, 18.0, 16.0, 14.0, 12.0, 10.0, 8.0]
                            : [40.0, 36.0, 32.0, 28.0, 24.0, 22.0, 20.0, 18.0, 16.0, 14.0, 12.0, 10.0, 8.0],
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: context.isPhone ? 32 : 40,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          color: Colors.white,
                          height: context.isPhone ? 1.2 : 1.1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'คะแนน',
                        style: TextStyle(
                          fontSize: context.isPhone ? 12 : 16,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          color: Colors.white,
                          height: 1.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: VerticalDivider(
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'VDO Meet',
                        style: TextStyle(
                          fontSize: context.isPhone ? 12 : 16,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AutoSizeText(
                            vdoMeet.toString(),
                            presetFontSizes: context.isPhone
                                ? const [48.0, 40.0, 32.0, 24.0, 22.0, 16.0, 14.0, 12.0, 10.0, 8.0]
                                : [68.0, 60.0, 56.0, 48.0, 40.0, 32.0, 24.0, 22.0, 16.0, 14.0, 12.0, 10.0, 8.0],
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: Assets.assetsFontsAnakotmaiMedium,
                              color: kPrimaryColor,
                              height: 1.0,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            'นาที',
                            style: TextStyle(
                              fontSize: context.isPhone ? 12 : 16,
                              fontFamily: Assets.assetsFontsAnakotmaiMedium,
                              color: kPrimaryColor,
                              height: 1.0,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
      padding: EdgeInsets.symmetric(horizontal: context.isPhone ? 8.0 : 16.0, vertical: context.isPhone ? 8.0 : 16.0),
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
