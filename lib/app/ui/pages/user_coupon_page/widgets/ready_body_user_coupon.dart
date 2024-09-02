import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../component/convert_image_component.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../../controllers/user_coupont_controller.dart';
import '../../../../data/models/user_coupon.dart';
import '../../../../routes/app_routes.dart';
import '../../../../component/dol_durma_clipper.dart';

class ReadyBodyUserCoupon extends GetWidget<UserCouponController> {
  ReadyBodyUserCoupon({super.key});

  final DateFormat _dateFormat = DateFormat('d MMM yyyy', 'th_TH');

  @override
  Widget build(BuildContext context) {
    final double cardSize = context.isPhone ? 120.0 : 160.0;
    const BorderRadius borderRadius = BorderRadius.only(
      topRight: Radius.circular(10.0),
      bottomRight: Radius.circular(10.0),
    );

    return Obx(() {
      if (controller.isLoading1) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final readyCoupon = controller.readyCouponModel.value.data?.readyCoupon;

      if ((readyCoupon ?? []).isEmpty) {
        return Center(
          child: Text(
            'ไม่มีคูปอง',
            style: TextStyle(
              fontSize: context.isPhone ? 24 : 32,
              fontFamily: Assets.assetsFontsAnakotmaiLight,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }

      // final myCouponList = readyCoupon?.where((element) => element.activeDate == null && element.expireDate!.isAfter(controller.now)).toList();

      return SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Padding(
            padding: EdgeInsets.all(context.isPhone ? 8.0 : 16.0),
            child: Column(
              children: readyCoupon!.map((coupon) {
                return ClipPath(
                  clipper: DolDurmaClipper(
                    length: context.isPhone ? 4 : 5,
                    radius: context.isPhone ? 8.0 : 10.0,
                  ),
                  child: Card(
                    color: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: borderRadius,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: cardSize,
                      decoration: const BoxDecoration(
                        borderRadius: borderRadius,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              _buildImageCoupon(coupon.pointStatement!.product!.coverPageUrl!),
                              _buildDetailCoupon(coupon),
                            ],
                          ),
                          _buildUseBottonCoupon(coupon),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildImageCoupon(String imageURL) {
    BuildContext context = Get.context!;
    final double imageSize = context.isPhone ? 120.0 : 160.0;

    return Image.network(
      ConvertImageComponent.getImages(imageURL: imageURL),
      width: imageSize,
      height: imageSize,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: imageSize,
          height: imageSize,
          color: Colors.grey,
          child: const Center(
            child: Icon(
              Icons.image,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailCoupon(UserCoupon coupon) {
    BuildContext context = Get.context!;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(context.isPhone ? 16.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth - (context.isPhone ? 80.0 : 104.0),
                  child: Text(
                    coupon.pointStatement!.title ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: context.isPhone ? 16 : 24,
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      color: Colors.grey.shade700,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            Text(
              'ใช้งานได้ถึง\t' '${_dateFormat.format(coupon.expireDate!)}',
              style: TextStyle(
                fontSize: context.isPhone ? 12 : 16,
                fontFamily: Assets.assetsFontsAnakotmaiLight,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUseBottonCoupon(UserCoupon coupon) {
    BuildContext context = Get.context!;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: context.isPhone ? 8.0 : 16.0),
        child: TextButton(
          onPressed: () async {
            Get.toNamed(
              AppRoutes.USED_COUPON,
              parameters: {
                'couponId': coupon.id!,
                'productId': coupon.productId!,
                'expireDate': coupon.expireDate!.toIso8601String(),
              },
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            minimumSize: Size(context.isPhone ? 80.0 : 96.0, context.isPhone ? 32.0 : 40.0),
          ),
          child: Text(
            'ใช้งาน',
            style: TextStyle(
              fontSize: context.isPhone ? 14 : 20,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
