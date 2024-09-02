import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../../controllers/point_main_controller.dart';
import '../../../../controllers/used_coupon_controller.dart';
import '../../../../controllers/user_coupont_controller.dart';
import '../../../utils/enum.dart';

class ButtonUsedCoupon extends GetWidget<UsedCouponController> {
  const ButtonUsedCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: context.isPhone ? 48.0 : 62.0),
          child: Text(
            'สำหรับพนักงานเท่านั้น',
            style: TextStyle(
              fontSize: context.isPhone ? 16 : 24,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              color: kPrimaryColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: context.isPhone ? 16.0 : 24.0),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, context.isPhone ? 40.0 : 56.0)),
              maximumSize: MaterialStateProperty.all<Size>(Size(double.infinity, context.isPhone ? 40.0 : 56.0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(56.0),
                  side: const BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
            onPressed: () {
              Get.dialog(
                barrierDismissible: false,
                AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    'ยืนยันการใช้งานคูปอง',
                    style: context.isPhone ? Get.textTheme.titleSmall : Get.textTheme.titleMedium,
                  ),
                  content: Text(
                    'คุณต้องการใช้งานคูปองนี้หรือไม่ ?',
                    style: context.isPhone
                        ? Get.textTheme.bodySmall!.copyWith(
                            fontSize: 18.0,
                            color: Colors.black54,
                          )
                        : Get.textTheme.bodyMedium!.copyWith(
                            fontSize: 26.0,
                            color: Colors.black54,
                          ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (Get.isDialogOpen ?? false) Get.back();
                      },
                      child: Text(
                        'ยกเลิก',
                        style: context.isPhone ? Get.textTheme.titleSmall : Get.textTheme.titleMedium,
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

                        await controller.fetchUsedCoupon().then((value) async {
                          if (Get.isDialogOpen ?? false) Get.back();

                          String message;
                          message = value.message ?? 'คุณไม่สามารถแลกคูปองได้';

                          if (message == 'Counpon is not active.') message = 'คูปองไม่ทำงาน';
                          if (message == 'Redeem coupon is success.') message = 'แลกคูปองสำเร็จ';

                          if ((value.status ?? 0) == 0) {
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

                          final userCouponController = Get.put(UserCouponController());
                          await userCouponController.fetchSarchUserCouponRedeem();
                          await userCouponController.fetchSarchUserCouponUse();
                          await userCouponController.fetchSarchUserCouponExpired();

                          final pointMainController = Get.put(PointMainController());
                          await pointMainController.getPointContent();

                          Get.dialog(
                            barrierDismissible: false,
                            _buildAlertDialog(
                              context,
                              alertType: AlertType.success,
                              title: 'แลกคูปองสำเร็จ',
                              content: message,
                              onPressed: () {
                                if (Get.isDialogOpen ?? false) Get.back();

                                Get.back();
                              },
                            ),
                          );
                          return;
                        });
                      },
                      child: Text(
                        'ยืนยัน',
                        style: context.isPhone
                            ? Get.textTheme.titleSmall!.copyWith(
                                color: kPrimaryColor,
                              )
                            : Get.textTheme.titleMedium!.copyWith(
                                color: kPrimaryColor,
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'กดเพื่อยืนยันการใช้งานคูปอง',
              style: context.isPhone
                  ? Get.textTheme.titleSmall!.copyWith(
                      color: kPrimaryColor,
                    )
                  : Get.textTheme.titleMedium!.copyWith(
                      color: kPrimaryColor,
                    ),
            ),
          ),
        ),
      ],
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
}
