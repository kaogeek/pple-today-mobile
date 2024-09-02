import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/convert_time_componenet.dart';
import '../../../../controllers/hash_tag_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class ProfilePost extends GetView<HashTagController> {
  final int index;
  final VoidCallback? onPressedUGC;

  const ProfilePost(
    this.index, {
    Key? key,
    required this.onPressedUGC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 8),
      onTap: () {
        String? pageId = controller.hashTagPostModel.data![index].post!.page!.id;
        if (pageId != null) {
          Get.toNamed(
            AppRoutes.PAGE_PROFILE,
            arguments: {'PAGE_ID': pageId},
          );
        }
      },
      leading: (controller.hashTagPostModel.data![index].post!.page!.signUrl ??
                  controller.hashTagPostModel.data![index].post!.page!.coverSignUrl ??
                  '')
              .isEmpty
          ? CircleAvatar(
              backgroundImage: AssetImage(Assets.assetsImagesPlaceholderPerson),
            )
          : CircleAvatar(
              backgroundImage: NetworkImage(controller.hashTagPostModel.data![index].post!.page!.signUrl ??
                  controller.hashTagPostModel.data![index].post!.page!.coverSignUrl!),
            ),
      title: Text(
        controller.hashTagPostModel.data![index].post?.page?.name ?? '',
        maxLines: 1,
        style: TextStyle(
          color: kPrimaryColor,
          fontFamily: Assets.assetsFontsAnakotmaiMedium,
          fontSize: 14,
          // overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: Row(
        children: [
          () {
            String? typePost = controller.hashTagPostModel.data![index].post!.type;

            switch (typePost) {
              case 'GENERAL':
                return _buildDotTypePost(
                  typePost: 'ทั่วไป',
                  colorCode: kColorCodeGray,
                );

              case 'NEEDS':
                return _buildDotTypePost(
                  typePost: 'มองหา',
                  colorCode: kColorCodeDarkBlue,
                );

              case 'MEMBERSHIP':
                return _buildDotTypePost(
                  typePost: 'สมาชิกพรรค',
                  colorCode: kColorCodePrimary,
                );

              case 'FULFILLMENT':
                return _buildDotTypePost(
                  typePost: 'เติมเต็ม',
                  colorCode: kColorCodeDarkBlue,
                );

              default:
                return _buildDotTypePost(
                  typePost: 'ทั่วไป',
                  colorCode: kColorCodeGray,
                );
            }
          }(),
          Text(
            controller.hashTagPostModel.data![index].post!.createdDate == null
                ? ''
                : ConvertTimeComponenet.convertToAgo(controller.hashTagPostModel.data![index].post!.createdDate!),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: textGrey,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      // *UGC
      trailing: onPressedUGC == null
          ? null
          : IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: const Icon(
                Icons.more_horiz_rounded,
                color: primaryBlue,
              ),
              onPressed: onPressedUGC,
            ),
    );
  }

  Widget _buildDotTypePost({required String typePost, required int colorCode}) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Color(colorCode),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 24),
          child: Text(
            typePost,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: textGrey,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
