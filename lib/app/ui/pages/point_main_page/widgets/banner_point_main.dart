import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/convert_image_component.dart';
import '../../../../controllers/point_main_controller.dart';
import '../../../../routes/app_routes.dart';

class BannerPointMain extends GetWidget<PointMainController> {
  const BannerPointMain({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() {
        final data = controller.pointContentModel.value.data;

        return (data?.pointEvent ?? []).isEmpty
            ? const SizedBox()
            : Padding(
                padding: EdgeInsets.symmetric(
                  // horizontal: context.isPhone ? 8.0 : 24.0,
                  vertical: context.isPhone ? 8.0 : 16.0,
                ),
                child: data!.pointEvent!.length == 1
                    ? GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.POINT_EVENT_DETAIL,
                            parameters: {
                              'pointEventId': data.pointEvent!.first.id!,
                            },
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: context.isPhone ? 16.0 : 24.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              data.pointEvent!.first.coverPageUrl != null || data.pointEvent!.first.coverPageUrl!.isNotEmpty
                                  ? ConvertImageComponent.getImages(imageURL: data.pointEvent!.first.coverPageUrl!)
                                  : data.pointEvent!.first.s3CoverPageUrl ?? '',
                              fit: BoxFit.cover,
                              width: context.isPhone ? (context.width - 32.0) : (context.width / 1.4),
                              height: context.isPhone ? 240.0 : 480.0,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: context.isPhone ? (context.width - 32.0) : (context.width / 1.4),
                                  height: context.isPhone ? 240.0 : 480.0,
                                  color: Colors.grey,
                                  child: const Center(
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.white,
                                      size: 48.0,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Container(
                        //   width: context.isPhone ? (context.width - 32.0) : (context.width - 48.0),
                        //   height: context.isPhone ? 240.0 : 480.0,
                        //   margin: EdgeInsets.symmetric(
                        //     horizontal: context.isPhone ? 16.0 : 24.0,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey,
                        //     borderRadius: BorderRadius.circular(10.0),
                        //     image: DecorationImage(
                        //       image: NetworkImage(
                        //         data.pointEvent!.first.coverPageUrl != null || data.pointEvent!.first.coverPageUrl!.isNotEmpty
                        //             ? ConvertImageComponent.getImages(imageURL: data.pointEvent!.first.coverPageUrl!)
                        //             : data.pointEvent!.first.s3CoverPageUrl ?? '',
                        //       ),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                      )
                    : SizedBox(
                        width: context.width,
                        height: context.isPhone ? 240.0 : 480.0,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            disableCenter: true,
                            viewportFraction: 0.92,
                            enableInfiniteScroll: false,
                            initialPage: 0,
                          ),
                          items: data.pointEvent!.map((e) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.POINT_EVENT_DETAIL,
                                  parameters: {
                                    'pointEventId': e.id!,
                                  },
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: context.isPhone ? 16.0 : 24.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    e.coverPageUrl != null || e.coverPageUrl!.isNotEmpty ? ConvertImageComponent.getImages(imageURL: e.coverPageUrl!) : e.s3CoverPageUrl ?? '',
                                    fit: BoxFit.cover,
                                    width: context.isPhone ? (context.width - 32.0) : (context.width / 1.4),
                                    height: context.isPhone ? 240.0 : 480.0,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: context.isPhone ? (context.width - 32.0) : (context.width / 1.4),
                                        height: context.isPhone ? 240.0 : 480.0,
                                        color: Colors.grey,
                                        child: const Center(
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.white,
                                            size: 48.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              //   Container(
                              //     width: context.isPhone ? (context.width - 32.0) : (context.width / 1.4),
                              //     height: context.isPhone ? 240.0 : 480.0,
                              //     margin: EdgeInsets.only(right: context.isPhone ? 16.0 : 24.0),
                              //     decoration: BoxDecoration(
                              //       color: Colors.grey,
                              //       borderRadius: BorderRadius.circular(10.0),
                              //       image: DecorationImage(
                              //         image: NetworkImage(
                              //           e.coverPageUrl != null || e.coverPageUrl!.isNotEmpty ? ConvertImageComponent.getImages(imageURL: e.coverPageUrl!) : e.s3CoverPageUrl ?? '',
                              //         ),
                              //         fit: BoxFit.cover,
                              //       ),
                              //     ),
                              //   ),
                            );
                          }).toList(),
                        ),
                      ),
              );
      }),
    );
  }
}
