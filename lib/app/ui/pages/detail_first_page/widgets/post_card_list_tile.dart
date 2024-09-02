// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/convert_image_component.dart';
import '../../../../controllers/detail_first_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class PostCardListTile extends GetWidget<DetailFirstController> {
  const PostCardListTile(this._dataModel, {super.key});

  final _dataModel;

  @override
  Widget build(BuildContext context) {
    if ((_dataModel?.contents ?? []).isEmpty) return const SizedBox();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(top: 16),
          title: Text(
            _dataModel.title!,
            style: TextStyle(
              fontSize: context.isPhone ? 24 : 32,
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
        _headingPost(
          context,
          postId: _dataModel!.contents!.first.post?.id ?? '',
        ),
        SizedBox(height: context.isPhone ? 16 : 32),
        ..._dataModel!.contents!.sublist(1).map(
          (e) {
            return _subItemsPosts(
              context,
              postId: e.post!.id!,
              imageURL: e.coverPageSignUrl!,
              title: e.post!.title!,
              by: e.post!.page!.name!,
            );
          },
        ),
        const SizedBox(height: 16),
        const Divider(thickness: 8),
      ],
    );
  }

  Widget _headingPost(BuildContext context, {required String postId}) {
    final _imageSize = context.isPhone ? 400.0 : 600.0;

    return GestureDetector(
      onTap: () {
        if (postId.isNotEmpty) {
          Get.toNamed(
            AppRoutes.POST_DETAIL,
            arguments: {
              'POST_ID': postId,
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
          /// Image Banner
          Container(
            width: Get.width,
            height: _imageSize,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                _dataModel!.contents!.first.coverPageUrl != null
                    ? ConvertImageComponent.getImages(imageURL: _dataModel!.contents!.first.coverPageUrl!)
                    : Assets.placeholderPerson,
                fit: BoxFit.cover,
                width: Get.width,
                height: _imageSize,
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

          /// Content
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              _dataModel!.contents!.first.post!.title ?? '',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.isPhone ? 20 : 28,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
            ),
          ),

          /// By
          Text(
            'โดย\t' '${_dataModel!.contents!.first.post!.page!.name ?? ''}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: context.isPhone ? 12 : 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _subItemsPosts(
    BuildContext context, {
    required String postId,
    required String imageURL,
    required String title,
    required String by,
  }) {
    final _imageSize = context.isPhone ? 88.0 : 160.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (postId.isNotEmpty) {
              Get.toNamed(
                AppRoutes.POST_DETAIL,
                arguments: {
                  'POST_ID': postId,
                  'FOCUS': false,
                },
              );
              return;
            }
          },
          child: Row(
            children: [
              /// Image
              Container(
                width: _imageSize,
                height: _imageSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: NetworkImage(imageURL),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Content
                      Text(
                        '$title' '\n',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.isPhone ? 16 : 24,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        ),
                      ),

                      /// By
                      Text(
                        'โดย\t' '$by',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: context.isPhone ? 12 : 18,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}
