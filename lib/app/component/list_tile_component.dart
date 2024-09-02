import 'package:flutter/material.dart';

import '../ui/utils/assets.dart';
import '../ui/utils/enum.dart';

class ListTileComponent extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final void Function()? onTap;
  final ListTileType type;
  final Color? color;

  const ListTileComponent({
    Key? key,
    required this.title,
    required this.trailing,
    required this.onTap,
    this.type = ListTileType.info,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: ListTile(
        tileColor: color,
        title: Text(
          title,
          style: TextStyle(
            color: type == ListTileType.delete ? Colors.red : Colors.black,
            fontSize: 14,
            fontFamily: Assets.assetsFontsAnakotmaiMedium,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
