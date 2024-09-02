// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      leading: BackButton(
        color: kPrimaryColor,
        onPressed: () => Get.back(),
      ),
      title: Image.asset(
        // TODO: Change to your logo
        // Assets.images.group10673PNG,
        Assets.assetsIconPpleTransparentO,
        // width: 150,
        // height: 150,
        width: 56,
        height: 56,
        fit: BoxFit.contain,
      ),
      automaticallyImplyLeading: false,
      centerTitle: false,
      floating: true,
    );
  }
}
