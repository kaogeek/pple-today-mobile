import 'package:flutter/material.dart';

import '../../../utils/assets.dart';

class ProfileListTile extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final GestureTapCallback? onTap;

  const ProfileListTile({Key? key, required this.titleText, required this.subTitleText, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
            ),
          ),
          Text(
            subTitleText,
            maxLines: 1,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
        size: 16,
      ),
    );
  }
}
