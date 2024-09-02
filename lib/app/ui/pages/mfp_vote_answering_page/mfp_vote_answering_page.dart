// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/read_more_text.dart';
import '../../../controllers/mfp_vote_answering_controller.dart';
import '../../../routes/app_routes.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import 'widgets/cover_image.dart';

class MfpVoteAnsweringPage extends GetView<MfpVoteAnsweringController> {
  MfpVoteAnsweringPage({Key? key}) : super(key: key);

  @override
  MfpVoteAnsweringController controller = Get.put(MfpVoteAnsweringController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: GestureDetector(
              onTap: () {
                if (Get.currentRoute == AppRoutes.MFP_VOTE_ANSWERING) Get.back();
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black.withOpacity(0.5),
                child: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        controller: controller.scrollController,
        child: Stack(
          children: [
            const CoverImage(),
            Column(
              children: [
                const SizedBox(height: 400),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: ReadMoreText(
                            controller.voteTitle,
                            trimLines: 6,
                            trimLength: 200,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: Assets.assetsFontsAnakotmaiMedium,
                            ),
                          ),
                        ),
                        Obx(() => (controller.voteTextModel.value.data ?? []).isEmpty
                            ? const SizedBox()
                            : ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.voteTextModel.value.data!.length,
                                itemBuilder: (context, index) {
                                  final _data = controller.voteTextModel.value.data![index];

                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (controller.showVoterName && _data.user != null)
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              leading: ClipRRect(
                                                borderRadius: BorderRadius.circular(50.0),
                                                child: (_data.user!.imageUrl ?? '').isEmpty
                                                    ? const Icon(
                                                        Icons.person,
                                                        color: Colors.grey,
                                                      )
                                                    : Image.network(
                                                        _data.user!.imageUrl ?? '',
                                                        height: 36,
                                                        width: 36,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context, error, stackTrace) {
                                                          return const Icon(
                                                            Icons.person,
                                                            color: Colors.white,
                                                          );
                                                        },
                                                      ),
                                              ),
                                              title: Text(
                                                '${_data.user!.firstName ?? ''}\t${_data.user!.lastName ?? ''}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                                ),
                                              ),
                                            ),
                                          ReadMoreText(
                                            _data.answer ?? '',
                                            trimLines: 6,
                                            trimLength: 200,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade800,
                                              fontFamily: Assets.assetsFontsAnakotmaiLight,
                                            ),
                                          ),

                                          // const SizedBox(height: 8),
                                          // Text(
                                          //   _data.detail ?? '',
                                          //   style: TextStyle(
                                          //     fontSize: 14,
                                          //     fontFamily: Assets.fonts.anakotmaiRegular,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  );

                                  /* Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        // child: Obx(() => controller.selectedOptionIndex.value == index
                                        //     ? const Icon(
                                        //         Icons.check,
                                        //         color: Colors.white,
                                        //         size: 16,
                                        //       )
                                        //     : const SizedBox()),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _data.answer ?? '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ); */
                                },
                              )),

                        /// Load More
                        Obx(() => SafeArea(
                              top: false,
                              child: SizedBox(
                                height: kToolbarHeight,
                                child: Center(
                                  child: controller.isLoadMoreRunning.value
                                      ? const CircularProgressIndicator(color: kPrimaryColor)
                                      : controller.isFinalLoadMore.value
                                          ? const Text('ไม่มีข้อมูลเพิ่มเติมแล้ว')
                                          : const SizedBox(),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: controller.scrollController.hasClients && controller.scrollController.offset > 100
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           controller.scrollController.animateTo(
      //             0,
      //             duration: const Duration(milliseconds: 500),
      //             curve: Curves.easeInOut,
      //           );
      //         },
      //         child: const Icon(Icons.keyboard_arrow_up_outlined),
      //       )
      //     : null,
    );
  }
}
