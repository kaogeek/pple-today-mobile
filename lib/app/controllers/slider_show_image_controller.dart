import 'package:get/get.dart';

class SliderShowImageController extends GetxController {

  SliderShowImageArguments arguments = Get.arguments;

  int index = 0;

  List<T> mapPing<T>(Function handler) {
    List<T> result = [];
    for (var i = 0; i < arguments.galleryList.length; i++) {
      result.add(handler(i, arguments.galleryList[i]));
    }
    return result;
  }
}

class SliderShowImageArguments {
  final List galleryList;
  // final int current;

  SliderShowImageArguments({
    required this.galleryList,
    // required this.current,
  });
}
