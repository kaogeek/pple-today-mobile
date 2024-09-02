import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/point_event_detail_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class AppBarPointPointEventDetail extends GetWidget<PointEventDetailController> implements PreferredSizeWidget {
  const AppBarPointPointEventDetail({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: const BackButton(color: kPrimaryColor),
      title: Text(
        'รายละเอียด',
        style: TextStyle(
          fontSize: context.isPhone ? 24 : 32,
          fontFamily: Assets.assetsFontsAnakotmaiLight,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
