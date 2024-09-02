// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/detail_first_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';

class PostCard extends GetWidget<DetailFirstController> {
  const PostCard(this._dataModel, {super.key});

  final _dataModel;

  @override
  Widget build(BuildContext context) {
    if ((_dataModel?.contents ?? []).isEmpty || (_dataModel?.contents ?? []).length <= 1) return const SizedBox();

    final _imageSize = context.isPhone ? 320.0 : 450.0;

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
                // TODO: navigate to page round robin
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ..._dataModel!.contents!.sublist(1).map(
                (e) {
                  return GestureDetector(
                    onTap: () {
                      if ((e.post?.id ?? '').isNotEmpty) {
                        Get.toNamed(
                          AppRoutes.POST_DETAIL,
                          arguments: {
                            'POST_ID': e.post!.id!,
                            'FOCUS': false,
                          },
                        );
                        return;
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          /// Background Image
                          Container(
                            width: _imageSize,
                            height: _imageSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: NetworkImage(e.coverPageSignUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          /// Gradient Overlay
                          Container(
                            width: _imageSize,
                            height: _imageSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black,
                                  if (!context.isPhone) Colors.black.withOpacity(0.7),
                                  Colors.black.withOpacity(0.5),
                                  Colors.black.withOpacity(0.2),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),

                          /// Content
                          SizedBox(
                            width: _imageSize,
                            height: _imageSize,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  /// Title
                                  Text(
                                    e.post?.title ?? '',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: context.isPhone ? 20 : 28,
                                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: Row(
                                      children: [
                                        /// Image Avatar
                                        CircleAvatar(
                                          radius: context.isPhone ? 16 : 24,
                                          backgroundImage: NetworkImage(e.post!.page!.imageUrl!),
                                        ),
                                        const SizedBox(width: 8),

                                        /// By
                                        Expanded(
                                          child: Text(
                                            'โดย\t' '${e.post!.page!.name!}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: context.isPhone ? 12 : 20,
                                              fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Divider(thickness: 8),
      ],
    );
  }
}
