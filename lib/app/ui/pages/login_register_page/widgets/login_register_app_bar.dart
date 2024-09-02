import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

class LoginRegisterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginRegisterAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(
        color: kPrimaryColor,
        onPressed: () => Get.back(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
