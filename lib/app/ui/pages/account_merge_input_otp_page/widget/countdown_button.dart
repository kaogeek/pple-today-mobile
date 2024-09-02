// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/account_merge_controller.dart';
import '../../../../controllers/timer_controllor.dart';
import '../../../utils/colors.dart';

class CountdownButton extends StatelessWidget {
  CountdownButton({Key? key}) : super(key: key);

  AccountMergeController controller = Get.put(AccountMergeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimerController>(
      init: TimerController(),
      initState: (_) {},
      builder: (timeController) {
        final _timeOut = timeController.time == '00:00';

        return TextButton(
          onPressed: () async {
            if (_timeOut) {
              timeController.startTimer(timeController.timecount);
              await controller.fetchSendOTP(controller.arguments.email);
            } else {
              SnackBarComponent.show(
                title: 'กรุณารอสักครู่',
                type: SnackBarType.warning,
              );
            }
          },
          child: Text(
            _timeOut ? 'ส่งรหัส OTP อีกครั้ง' : timeController.time,
            style: TextStyle(
              fontSize: 20,
              color: _timeOut ? kPrimaryColor : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
