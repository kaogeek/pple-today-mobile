import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../data/models/response_model.dart';
import '../data/services/point_service.dart';

class RankingController extends GetxController {
  final _isLoading = true.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  var dataModel = ResponseModel().obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    isLoading = true;
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
    //     debugPrint('Load more', wrapWidth: 1024);
    //     fetchSarchRanking(offset: dataModel.value.data!.sortAccumulatePoint!.rankingPoint!.length);
    //   }
    // });
    super.onInit();
  }

  @override
  void onReady() {
    fetchSarchRanking().then((_) => isLoading = false);
    super.onReady();
  }

  Future<void> fetchSarchRanking({int offset = 0}) async {
    PointService service = Get.put(PointService());

    Response response = await service.sarchRanking(
      offset: offset,
      limit: 100,
    );

    if (response.isOk) {
      dataModel.value = ResponseModel.fromJson(response.body);
      //   offset == 0
      //       ? dataModel.value = ResponseModel.fromJson(response.body)
      //       : dataModel.update((val) {
      //           val!.data!.sortAccumulatePoint!.rankingPoint!.addAll(ResponseModel.fromJson(response.body).data?.sortAccumulatePoint?.rankingPoint ?? []);
      //         });

      if (dataModel.value.data == null) return;

      dataModel.value.data!.sortAccumulatePoint!.rankingPoint!.sort((a, b) => b.accumulatePoint!.compareTo(a.accumulatePoint!));
    } else {
      debugPrint('${response.body}', wrapWidth: 1024);
    }

    dataModel.refresh();

    return;
  }
}
