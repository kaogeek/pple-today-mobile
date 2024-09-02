// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/dotted_line.dart';
import '../../../../controllers/profile_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class MyPageProfileUser extends StatelessWidget {
  MyPageProfileUser({Key? key}) : super(key: key);

  ProfileController controller = Get.put(ProfileController());

  final double _width = 75;
  final double _height = 75;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              'เพจที่ดูแล',
              style: Get.textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontSize: 18,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
            ),
          ),
          (controller.userAccessPageModel.data ?? []).isEmpty
              ? _buildAddPageWidget()
              : SizedBox(
                  height: 160,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.userAccessPageModel.data!.length + 1,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return index == controller.userAccessPageModel.data!.length ? _buildAddPageWidget() : _buildAdminPageWidget(index);
                      }),
                ),
        ],
      ),
    );
  }

  Widget _buildAdminPageWidget(int index) {
    final _data = controller.userAccessPageModel.data![index];

    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: SizedBox(
        width: _width,
        height: 160,
        child: GestureDetector(
          onTap: () {
            if (_data.page != null && _data.page!.id != null && _data.page!.id!.isNotEmpty) {
              Get.toNamed(
                AppRoutes.PAGE_PROFILE,
                arguments: {'PAGE_ID': _data.page!.id!},
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: (_data.page?.imageUrl ?? '').isEmpty
                    ? Image.asset(
                        Assets.assetsImagesPlaceholderPerson,
                        width: _width,
                        height: _height,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        _data.page!.imageUrl!,
                        width: _width,
                        height: _height,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return Center(
                            child: CircularProgressIndicator(
                              color: kPrimaryColor,
                              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            Assets.assetsImagesPlaceholderPerson,
                            width: _width,
                            height: _height,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: Text(
                  _data.page?.name?.isEmpty ?? true ? 'ไม่มีชื่อเพจ' '\n' : _data.page!.name! + '\n',
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: Assets.assetsFontsAnakotmaiMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddPageWidget() {
    return SizedBox(
      width: _width,
      height: 160,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            AppRoutes.SYNC_PAGE_SOCIAL,
            arguments: {
              'BACK_BUTTON': true,
              'SKIP_BUTTON': false,
            },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FDottedLine(
              color: Colors.grey,
              height: _height,
              width: _width,
              space: 5.0,
              corner: FDottedLineCorner.all(12),
              child: const Icon(
                Icons.add,
                size: 32,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                'สร้างเพจ' '\n',
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
