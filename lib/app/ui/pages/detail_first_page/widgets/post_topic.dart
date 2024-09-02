// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/convert_image_component.dart';
import '../../../../controllers/detail_first_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class PostTopic extends GetWidget<DetailFirstController> {
  const PostTopic(this._dataModel, {super.key});

  final _dataModel;

  @override
  Widget build(BuildContext context) {
    if (_dataModel == null || _dataModel.post == null) return const SizedBox();

    return GestureDetector(
      onTap: () {
        if ((_dataModel.post?.id ?? '').isNotEmpty) {
          Get.toNamed(
            AppRoutes.POST_DETAIL,
            arguments: {
              'POST_ID': _dataModel.post!.id!,
              'FOCUS': false,
            },
          );
          return;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _dataModel.post!.title ?? '',
            style: TextStyle(
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              fontSize: context.isPhone ? 30 : 42,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              _dataModel.post!.detail ?? '',
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.isPhone ? 16 : 24,
              ),
            ),
          ),
          Container(
            width: Get.width,
            height: context.isPhone ? 400 : 600,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                _dataModel.coverPageUrl != null ? ConvertImageComponent.getImages(imageURL: _dataModel.coverPageUrl!) : Assets.placeholderPerson,
                fit: BoxFit.cover,
                width: Get.width,
                height: context.isPhone ? 400 : 600,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                      color: kPrimaryColor,
                    ),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'โดย\t' '${_dataModel.post!.page!.name ?? ''}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: context.isPhone ? 12 : 20,
                ),
              ),
            ),
          ),
          const Divider(thickness: 8),
        ],
      ),
    );
  }
}
