import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/album_card.dart';
import '../../../../controllers/hash_tag_controller.dart';

class ImagePost extends GetView<HashTagController> {
  final int index;

  const ImagePost(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (controller.hashTagPostModel.data![index].post!.gallery ?? []).isEmpty
        ? const SizedBox()
        : AlbumCard(
            gallery: controller.hashTagPostModel.data![index].post!.gallery!,
            onTap: null,
          );
  }
}
