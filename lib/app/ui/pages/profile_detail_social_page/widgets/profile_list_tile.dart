import 'package:flutter/material.dart';

import '../../../utils/assets.dart';

class ProfileListTile extends StatelessWidget {
  final String titleText;
  final Color titleColor;
  final String subTitleText;
  final Color? subTitleColor;

  const ProfileListTile(
      {Key? key,
      required this.titleText,
      this.titleColor = Colors.black,
      required this.subTitleText,
      this.subTitleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        titleText,
        style: TextStyle(
          fontSize: 16,
          color: titleColor,
          fontFamily: Assets.assetsFontsAnakotmaiMedium,
        ),
      ),
      trailing: Text(
        subTitleText,
        maxLines: 1,
        style: TextStyle(
          fontSize: 14,
          color: subTitleColor ?? Colors.grey.shade800,
        ),
      ),
    );
  }
}
