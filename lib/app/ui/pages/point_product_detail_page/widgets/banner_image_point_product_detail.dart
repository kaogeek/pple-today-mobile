import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/convert_image_component.dart';
import '../../../../controllers/point_product_detail_controller.dart';
import '../../../../routes/app_routes.dart';

class BannerImagePointProductDetail extends GetWidget<PointProductDetailController> {
  const BannerImagePointProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final productDetail = controller.dataModel.value.data!.productDetail!;

    return Center(
      child: FutureBuilder<ImageInfo>(
        future: _getImageInfo(
          ConvertImageComponent.getImages(imageURL: productDetail.coverPageUrl!),
        ),
        builder: (BuildContext context, AsyncSnapshot<ImageInfo> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              debugPrint('IMAGE_WIDTH: ${snapshot.data!.image.width}px', wrapWidth: 1024);
              debugPrint('IMAGE_HEIGHT: ${snapshot.data!.image.height}px', wrapWidth: 1024);
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.PHOTO_PERVIEW,
                    parameters: {'imageUrl': ConvertImageComponent.getImages(imageURL: productDetail.coverPageUrl!)},
                  );
                },
                child: Image.network(
                  ConvertImageComponent.getImages(imageURL: productDetail.coverPageUrl!),
                  width: snapshot.data!.image.width == snapshot.data!.image.height
                      ? context.isPhone
                          ? 240.0
                          : 480.0
                      : double.infinity,
                  height: context.isPhone ? 240.0 : 480.0,
                  fit: snapshot.data!.image.width < snapshot.data!.image.height ? BoxFit.fitWidth : BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Container(
                        width: double.infinity,
                        height: context.isPhone ? 240.0 : 480.0,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: context.isPhone ? 240.0 : 480.0,
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: context.isPhone ? 240.0 : 480.0,
                color: Colors.grey.shade300,
                child: const Center(
                  child: Icon(
                    Icons.image,
                    color: Colors.grey,
                  ),
                ),
              );
            }
          } else {
            return Container(
              width: double.infinity,
              height: context.isPhone ? 240.0 : 480.0,
              color: Colors.grey.shade300,
              child: const Center(
                child: Icon(
                  Icons.image,
                  color: Colors.grey,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<ImageInfo> _getImageInfo(String url) async {
    final ImageStream stream = NetworkImage(url).resolve(ImageConfiguration.empty);
    final Completer<ImageInfo> completer = Completer<ImageInfo>();
    void listener(ImageInfo info, bool _) {
      if (!completer.isCompleted) {
        completer.complete(info);
      }
    }

    stream.addListener(ImageStreamListener(listener));
    return completer.future;
  }
}
