import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/slider_show_image_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';

class SliderShowImagePage extends GetView<SliderShowImageController> {
  const SliderShowImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: kPrimaryColor),
      ),
      body: Container(
        color: Colors.black,
        width: Get.width,
        height: Get.height,
        child: controller.arguments.galleryList.length <= 1
            ? SizedBox(
                height: Get.height / 1.3,
                child: ClipRRect(
                  child: CachedNetworkImage(
                    height: Get.height / 2.0,
                    width: Get.width,
                    imageUrl: controller.arguments.galleryList.first is String
                        ? controller.arguments.galleryList.first
                        : controller.arguments.galleryList.first.imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        Assets.assetsImagesPlaceholderJPG,
                      );
                    },
                  ),
                ),
              )
            : GetBuilder<SliderShowImageController>(
                init: SliderShowImageController(),
                initState: (_) {},
                builder: (_) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: false,
                      height: Get.height / 1.3,
                      viewportFraction: 1,
                      onPageChanged: (index, data) {
                        controller.index = index;
                        controller.update();
                      },
                      initialPage: controller.index,
                    ),
                    items: controller.mapPing((int index, url) {
                      return ClipRRect(
                        child: CachedNetworkImage(
                          height: Get.height / 2.0,
                          width: Get.width,
                          imageUrl: url is String ? url : url.imageUrl,
                          fit: BoxFit.contain,
                          placeholder: (context, url) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              Assets.assetsImagesPlaceholderJPG,
                            );
                          },
                        ),
                      );
                    }),
                  );
                },
              ),
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.mapPing((int index, url) {
            return GetBuilder<SliderShowImageController>(
              init: SliderShowImageController(),
              initState: (_) {},
              builder: (_) {
                return Container(
                  width: 10,
                  height: 9,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.index == index ? kPrimaryColor : Colors.grey,
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
