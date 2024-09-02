import 'package:flutter/foundation.dart';

void checkExecutionTime(String log) {
  if (kDebugMode) {
    final stopwatch = Stopwatch()..start();
    stopwatch.stop();
    print('$log executed in ${stopwatch.elapsed}');
  }
}
