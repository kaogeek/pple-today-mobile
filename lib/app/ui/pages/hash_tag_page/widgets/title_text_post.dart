import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/hash_tag_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class TitleTextPost extends GetWidget<HashTagController> {
  final int index;

  const TitleTextPost(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (controller.hashTagPostModel.data![index].post!.title ?? '').isEmpty
        ? const SizedBox()
        : Padding(
            padding: EdgeInsets.only(
              left: 8,
              top: (controller.hashTagPostModel.data![index].post!.gallery ?? []).isEmpty ? 0 : 20,
            ),
            child: Text(
              controller.hashTagPostModel.data![index].post!.title!,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                fontSize: (controller.hashTagPostModel.data![index].post!.gallery ?? []).isEmpty ? 25 : 17,
                color: primaryBlue,
              ),
            ),
          );
  }
}
