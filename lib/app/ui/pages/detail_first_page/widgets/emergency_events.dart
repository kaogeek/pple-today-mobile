// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/convert_image_component.dart';
import '../../../../controllers/detail_first_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class EmergencyEvents extends GetWidget<DetailFirstController> {
  const EmergencyEvents(this._dataModel, {super.key});

  final _dataModel;

  @override
  Widget build(BuildContext context) {
    final _sizeImageWidth = Get.width;
    final _sizeImageHeight = context.isPhone ? 400.0 : 600.0;
    final _sizeTextTopic = context.isPhone ? 24.0 : 32.0;
    final _sizeTextTitle = context.isPhone ? 20.0 : 28.0;
    final _sizeTextDetail = context.isPhone ? 16.0 : 24.0;
    final _sizeTextBy = context.isPhone ? 12.0 : 20.0;

    return GestureDetector(
      onTap: () {
        if ((_dataModel.contents!.first.post?.id ?? '').isNotEmpty) {
          Get.toNamed(
            AppRoutes.POST_DETAIL,
            arguments: {
              'POST_ID': _dataModel.contents!.first.post!.id!,
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
          ListTile(
            contentPadding: const EdgeInsets.only(top: 16),
            title: Text(
              _dataModel.contents!.first.title ?? _dataModel.majorTrendHashTags?.first.name ?? '',
              style: TextStyle(
                fontSize: _sizeTextTopic,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
            ),
            /* trailing: SizedBox(
            width: 80,
            height: 32,
            child: TextButton(
              onPressed: () {
                // TODO: navigate to page round
              },
              child: Text(
                'ทั้งหมด',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ), */
          ),

          /// Image
          Container(
            width: _sizeImageWidth,
            height: _sizeImageHeight,
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                _dataModel.contents!.first.coverPageUrl != null
                    ? ConvertImageComponent.getImages(imageURL: _dataModel.contents!.first.coverPageUrl!)
                    : Assets.placeholderPerson,
                fit: BoxFit.cover,
                width: _sizeImageWidth,
                height: _sizeImageHeight,
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

          /// Title
          Text(
            _dataModel.contents!.first.post!.title ?? '',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              fontSize: _sizeTextTitle,
            ),
          ),

          /// Detail
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              _dataModel.contents!.first.post!.detail ?? '',
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: _sizeTextDetail,
              ),
            ),
          ),

          /// By
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'โดย\t' '${_dataModel.contents!.first.post!.page!.name ?? ''}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: _sizeTextBy,
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
