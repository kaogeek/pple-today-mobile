import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/read_more_text.dart';
import '../../../../controllers/hash_tag_controller.dart';
import '../../../utils/assets.dart';

class DetailTextPost extends GetWidget<HashTagController> {
  final int index;

  const DetailTextPost(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 16),
      child: ReadMoreText(
        controller.hashTagPostModel.data![index].post!.detail ?? '',
        trimLines: 6,
        trimLength: 200,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade700,
          fontFamily: Assets.assetsFontsAnakotmaiLight,
        ),
      ),
    );
  }
}
