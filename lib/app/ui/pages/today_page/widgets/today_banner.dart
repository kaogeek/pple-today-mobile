import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/carouse_loading.dart';
import '../../../../component/convert_image_component.dart';
import '../../../../controllers/today_controller.dart';
import '../../../../data/models/content_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/environment.dart';

class TodayBanner extends StatelessWidget {
  TodayBanner({Key? key}) : super(key: key);

  final _carouselController = CarouselController();
  final _current = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodayController>(
      init: TodayController(),
      initState: (_) {},
      builder: (controller) {
        try {
          if (controller.contentModel.data == null) {
            return CarouselLoading(
              height: context.isPhone ? Get.width + kToolbarHeight : (Get.height / 2) + kToolbarHeight,
            );
          }

          if (controller.contentModel.data!.emergencyEvents!.contents!.isNotEmpty) {
            return CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                enableInfiniteScroll: controller.contentModel.data!.emergencyEvents!.contents!.length > 1,
                onPageChanged: (index, reason) {
                  _current.value = index;
                },
                height: context.isPhone ? Get.width + kToolbarHeight : (Get.height / 2) + kToolbarHeight,
                viewportFraction: 1,
                disableCenter: true,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: controller.contentModel.data!.emergencyEvents!.contents!.map((emcs) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () => _onTap(emcs),
                      child: Column(
                        children: [
                          Container(
                            height: context.isPhone ? Get.width : Get.height / 2,
                            width: Get.width,
                            color: Colors.grey.withOpacity(.7),
                            child: CachedNetworkImage(
                              imageUrl: emcs.coverPageUrl != null ? ConvertImageComponent.getImages(imageURL: emcs.coverPageUrl!) : Assets.placeholderPerson,
                              fit: BoxFit.contain,
                              placeholder: (context, url) {
                                return const CarouselLoading();
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: kToolbarHeight,
                            color: kPrimaryColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      emcs.title ?? controller.contentModel.data!.emergencyEvents!.majorTrendHashTags?.first.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  if (controller.contentModel.data!.emergencyEvents!.contents!.length > 1)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: controller.contentModel.data!.emergencyEvents!.contents!.asMap().entries.map((entry) {
                                        return Obx(() => Container(
                                              width: 6,
                                              height: 6,
                                              margin: const EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white.withOpacity(
                                                  _current.value == entry.key ? .9 : .2,
                                                ),
                                              ),
                                            ));
                                      }).toList(),
                                    ),
                                  const Expanded(
                                    child: Text(
                                      'ดูเพิ่มเติม >',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }

          if (controller.contentModel.data!.pageRoundRobin!.contents!.isNotEmpty) {
            return CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                enableInfiniteScroll: controller.contentModel.data!.pageRoundRobin!.contents!.length > 1,
                onPageChanged: (index, reason) {
                  _current.value = index;
                },
                height: context.isPhone ? Get.width + kToolbarHeight : (Get.height / 2) + kToolbarHeight,
                viewportFraction: 1,
                disableCenter: true,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: controller.contentModel.data!.pageRoundRobin!.contents!.map((emcs) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () => _onTap(emcs),
                      child: Column(
                        children: [
                          Container(
                            height: context.isPhone ? Get.width : Get.height / 2,
                            width: Get.width,
                            color: Colors.grey.withOpacity(.7),
                            child: CachedNetworkImage(
                              imageUrl: emcs.coverPageUrl != null ? ConvertImageComponent.getImages(imageURL: emcs.coverPageUrl!) : Assets.placeholderPerson,
                              fit: BoxFit.contain,
                              placeholder: (context, url) {
                                return const CarouselLoading();
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: kToolbarHeight,
                            color: kPrimaryColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      emcs.title ?? controller.contentModel.data!.pageRoundRobin!.majorTrendHashTags?.first.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  if (controller.contentModel.data!.pageRoundRobin!.contents!.length > 1)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: controller.contentModel.data!.pageRoundRobin!.contents!.asMap().entries.map((entry) {
                                        return Obx(() => Container(
                                              width: 6,
                                              height: 6,
                                              margin: const EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white.withOpacity(
                                                  _current.value == entry.key ? .9 : .2,
                                                ),
                                              ),
                                            ));
                                      }).toList(),
                                    ),
                                  const Expanded(
                                    child: Text(
                                      'ดูเพิ่มเติม >',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }

          return const SizedBox();
        } catch (e) {
          return const SizedBox();
        }
      },
    );
  }

  void _onTap(Contents emcs) {
    if (emcs.post != null && emcs.post!.id != null) {
      Get.toNamed(
        AppRoutes.POST_DETAIL,
        arguments: {'POST_ID': emcs.post!.id!},
      );
      return;
    }

    Get.toNamed(
      AppRoutes.WEBVIEW_EMERGENCY,
      arguments: {
        'URL': '${Environment.domainName}/emergencyevent/${emcs.data!.emergencyEventId}',
        'TITLE': emcs.title,
        'ICON_IMAGE': emcs.coverPageSignUrl,
      },
    );
    return;
  }
}
