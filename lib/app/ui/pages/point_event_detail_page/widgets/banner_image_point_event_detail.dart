import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/convert_image_component.dart';
import '../../../../controllers/point_event_detail_controller.dart';

class BannerImagePointEventDetail extends GetWidget<PointEventDetailController> {
  const BannerImagePointEventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final pointEventDetail = controller.dataModel.value.data!.pointEventDetail!;

    return Center(
      child: FutureBuilder<ImageInfo>(
        future: _getImageInfo(
          ConvertImageComponent.getImages(imageURL: pointEventDetail.coverPageUrl!),
        ),
        builder: (BuildContext context, AsyncSnapshot<ImageInfo> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Image.network(
                ConvertImageComponent.getImages(imageURL: pointEventDetail.coverPageUrl!),
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
                    return const CircularProgressIndicator();
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: context.isPhone ? 240.0 : 480.0,
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              );
            } else {
              return Container(
                width: double.infinity,
                height: context.isPhone ? 240.0 : 480.0,
                color: Colors.grey.shade300,
                child: const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.grey,
                  ),
                ),
              );
            }
          } else {
            return const CircularProgressIndicator();
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
