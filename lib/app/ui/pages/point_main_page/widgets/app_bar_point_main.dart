import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/point_main_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class AppBarPointMain extends GetWidget<PointMainController> implements PreferredSizeWidget {
  const AppBarPointMain({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: const BackButton(color: kPrimaryColor),
      title: Text(
        'ประชาชน Point',
        style: TextStyle(
          fontSize: context.isPhone ? 24 : 32,
          fontFamily: Assets.assetsFontsAnakotmaiLight,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      actions: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Image.asset(
                  Assets.assetsImagesVector,
                  width: context.isPhone ? 24.0 : 32.0,
                  height: context.isPhone ? 16.0 : 24.0,
                  fit: BoxFit.fill,
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.USER_COUPON);
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: controller.confettiController,
                emissionFrequency: 0.0,
                numberOfParticles: 8,
                minBlastForce: 1,
                maxBlastForce: 8,
                blastDirection: 0,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                  Colors.yellow,
                  Colors.red,
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
