import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../controllers/photo_perview_controller.dart';
import '../../utils/colors.dart';

class PhotoPerviewPage extends GetView<PhotoPeriewController> {
  const PhotoPerviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: kPrimaryColor),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: PhotoView(
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered,
            imageProvider: NetworkImage(
              controller.imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
