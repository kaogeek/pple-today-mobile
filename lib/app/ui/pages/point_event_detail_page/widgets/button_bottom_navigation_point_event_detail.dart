import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../../controllers/point_event_detail_controller.dart';

class ButtonBottomNavigationPointEventDetail extends GetWidget<PointEventDetailController> {
  const ButtonBottomNavigationPointEventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Obx(() {
        final pointEventDetail = controller.dataModel.value.data?.pointEventDetail;
        // final fullCoupon = (pointEventDetail?.receiver ?? 0) == (pointEventDetail?.maximumLimit ?? 0);
        final isLink = pointEventDetail == null || pointEventDetail.link == null || pointEventDetail.link!.toString().isEmpty;

        final isActive = !controller.isLoading && (pointEventDetail != null) && !isLink;

        return _buildButton(
          active: isActive,
          onTap: () async {
            if (controller.isLoading || pointEventDetail == null) return;

            final Uri url = pointEventDetail.link!;
            if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
            }

            return;
          },
        );
      }),
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
            'เปิดดู',
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
