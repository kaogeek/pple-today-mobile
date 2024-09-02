import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../../controllers/point_main_controller.dart';
import '../../../../controllers/point_product_detail_controller.dart';
import '../../../utils/enum.dart';

class ButtonBottomNavigationPointProductDetail extends GetWidget<PointProductDetailController> {
  const ButtonBottomNavigationPointProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Obx(() {
        final productDetail = controller.dataModel.value.data?.productDetail;
        final fullCoupon = (productDetail?.receiverCoupon ?? 0) == (productDetail?.maximumLimit ?? 0);
        final activeDate = productDetail?.activeDate == null || productDetail!.activeDate!.isBefore(DateTime.now());
        final redeem = productDetail?.redeemCoupon ?? false;
        final used = productDetail?.useCoupon ?? false;

        final isActive = !controller.isLoading && (productDetail != null) && activeDate && !fullCoupon && !redeem && !used;

        return _buildButton(
          active: isActive,
          onTap: () async {
            if (controller.isLoading || productDetail == null) return;

            if (!activeDate || fullCoupon || redeem || used) {
              Get.dialog(
                _buildAlertDialog(
                  context,
                  alertType: AlertType.error,
                  title: 'ไม่สามารถแลกคูปองได้',
                  content: !activeDate
                      ? 'รายการนี้ยังไม่เปิดให้แลกคูปอง'
                      : redeem
                          ? 'คูปองนี้ได้ถูกแลกไปแล้ว'
                          : used
                              ? 'คูปองนี้ได้ถูกใช้ไปแล้ว'
                              : 'คูปองนี้ได้ถูกแลกครบแล้ว',
                  onPressed: () {
                    if (Get.isDialogOpen ?? false) Get.back();
                  },
                ),
              );
              return;
            }

            Get.dialog(
              barrierDismissible: false,
              AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  'ยืนยันการแลกคูปอง',
                  style: TextStyle(
                    fontSize: context.isPhone ? 16 : 24,
                    fontFamily: Assets.assetsFontsAnakotmaiMedium,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                content: Text(
                  'คุณต้องการแลกคูปองนี้หรือไม่ ?',
                  style: TextStyle(
                    fontSize: context.isPhone ? 18 : 26,
                    fontFamily: Assets.assetsFontsAnakotmaiLight,
                    color: Colors.black54,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (Get.isDialogOpen ?? false) Get.back();
                    },
                    child: Text(
                      'ยกเลิก',
                      style: TextStyle(
                        fontSize: context.isPhone ? 16 : 24,
                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (Get.isDialogOpen ?? false) Get.back();

                      Get.dialog(
                        barrierDismissible: false,
                        const AlertDialog(
                          backgroundColor: Colors.white,
                          content: SizedBox(
                            width: 66.0,
                            height: 66.0,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      );

                      await controller.fetchRedeemCoupon(title: productDetail.title!, detail: productDetail.detail!, point: productDetail.point!).then((value) async {
                        if (Get.isDialogOpen ?? false) Get.back();

                        if ((value.status ?? 0) == 0) {
                          String message;
                          message = value.message ?? 'คุณไม่สามารถแลกคูปองได้';

                          if (message == "You have had this point statement.") message = 'คุณได้แลกคูปองนี้ไปแล้ว';
                          if (message == "The point you have got is not enough.") message = 'คุณมีคะแนนไม่เพียงพอ';
                          if (message == "You have an error in your request's body. Check 'errors' field for more details!") message = 'คุณไม่สามารถแลกคูปองได้';

                          Get.dialog(
                            _buildAlertDialog(
                              context,
                              alertType: AlertType.error,
                              title: 'แลกคูปองไม่สำเร็จ',
                              content: message,
                              onPressed: () {
                                if (Get.isDialogOpen ?? false) Get.back();
                              },
                            ),
                          );
                          return;
                        }

                        final pointMainController = Get.put(PointMainController());
                        final accumulatePoint = pointMainController.pointContentModel.value.data!.accumulatePoint!.accumulatePoint!;
                        pointMainController.pointContentModel.update((val) {
                          val!.data!.accumulatePoint!.accumulatePoint = (accumulatePoint - productDetail.point!);
                        });
                        await pointMainController.getPointContent();

                        Get.dialog(
                          barrierDismissible: false,
                          _buildAlertDialog(
                            context,
                            alertType: AlertType.success,
                            title: 'แลกคูปองสำเร็จ',
                            content: 'คุณได้แลกคูปองสำเร็จ',
                            onPressed: () {
                              if (Get.isDialogOpen ?? false) Get.back();

                              Get.back(result: true);
                            },
                          ),
                        );
                        return;
                      });
                    },
                    child: Text(
                      'ยืนยัน',
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
            );

            return;
          },
        );
      }),
    );
  }

  Widget _buildAlertDialog(
    BuildContext context, {
    required AlertType alertType,
    required String title,
    required String content,
    required VoidCallback? onPressed,
  }) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
          fontSize: context.isPhone ? 16 : 24,
          fontFamily: Assets.assetsFontsAnakotmaiMedium,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            content,
            maxLines: 2,
            style: TextStyle(
              fontSize: context.isPhone ? 18 : 26,
              fontFamily: Assets.assetsFontsAnakotmaiLight,
              color: Colors.black54,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 16.0),
          if (alertType == AlertType.success)
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
              size: 56.0,
            ),
          if (alertType == AlertType.error)
            const Icon(
              Icons.error_rounded,
              color: Colors.red,
              size: 56.0,
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            'ตกลง',
            style: TextStyle(
              fontSize: context.isPhone ? 16 : 24,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              color: kPrimaryColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required bool active,
    required GestureTapCallback? onTap,
  }) {
    BuildContext context = Get.context!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.isPhone ? 48.0 : 56.0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: active ? kPrimaryColor : Colors.grey,
          borderRadius: const BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: Center(
          child: Text(
            'แลกคูปอง',
            style: TextStyle(
              fontSize: context.isPhone ? 16 : 24,
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
