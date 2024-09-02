import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';

class LoginRegisterLogo extends StatelessWidget {
  const LoginRegisterLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.assetsIconPpleTransparentO,
          ),
        ),
      ),
    );
  }
}
