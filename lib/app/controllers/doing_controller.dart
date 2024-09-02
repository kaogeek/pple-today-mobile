// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';

import '../data/models/doing_model.dart';
import '../data/models/objective_doing_model.dart';
import '../data/services/doing_service.dart';

class DoingController extends GetxController {
  final _service = DoingService();

  @override
  void onInit() {
    fetchGetDoing();
    fetchGetObjectivDoing();
    super.onInit();
  }

  DoingModel doingModel = DoingModel();
  ObjectiveDoingModel objectiveDoingModel = ObjectiveDoingModel();

  bool isLoadMore = false;
  bool isNotPost = false;

  int offsetObjective = 0;

  Future<void> fetchGetDoing() async {
    try {
      final DateTime dateTime = DateTime.now();

      DateTime dateTimeAgo = DateTime(
        dateTime.year,
        dateTime.month - 1,
        dateTime.day,
      );

      String? result = await _service.getDoing(dateTimeAgo);

      if (result == null) return;

      final json = jsonDecode(result);
      doingModel = DoingModel.fromJson(json);
    } catch (e) {
      printError(info: e.toString());
    }

    update();
    return;
  }

  Future<void> fetchGetObjectivDoing({
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      String? result = await _service.getObjectivDoing(
        offset: offset,
        limit: limit,
      );

      if (result == null) return;

      final json = jsonDecode(result);
      final model = ObjectiveDoingModel.fromJson(json);

      isNotPost = (model.data ?? []).isEmpty || model.data!.length < limit;

      offset != 0 ? objectiveDoingModel.data!.addAll(model.data ?? []) : objectiveDoingModel = model;
    } catch (e) {
      printError(info: e.toString());
    }

    update();
    return;
  }
}
