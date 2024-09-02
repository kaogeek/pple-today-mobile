import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  Timer? _timer;

  String time = '03:00';

  int remainingSeconds = 1;
  int timecount = 180;

  @override
  void onReady() {
    startTimer(timecount);
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  void startTimer(int seconds) {
    const duration = Duration(seconds: 1);

    remainingSeconds = seconds;

    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds < 0) {
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        time = minutes.toString().padLeft(2, '0') + ':' + seconds.toString().padLeft(2, '0');
        remainingSeconds--;
        update();
      }
    });
  }
}
