// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class ManagePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ManagePageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: kPrimaryColor,
        ),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'จัดการเพจ',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: Assets.assetsFontsAnakotmaiMedium,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
