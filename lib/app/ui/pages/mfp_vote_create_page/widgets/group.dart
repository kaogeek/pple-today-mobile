import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_create_controller.dart';
import '../../../utils/assets.dart';

class Group extends GetWidget<MfpVoteCreateController> {
  final String groupName;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const Group({Key? key, required this.groupName, required this.child, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            groupName,
            style: TextStyle(
              fontSize: 12,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: child,
          ),
        ],
      ),
    );
  }
}
