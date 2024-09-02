import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../controllers/privacy_policy_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/colors.dart';
import 'widgets/bottom_navi_tos.dart';
import 'widgets/terms_of_service.dart';

class PrivacyPolicyPage extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivacyPolicyController>(
      init: PrivacyPolicyController(),
      initState: (_) {},
      builder: (_) {
        return MainLayoutView(
          appBar: AppBar(
            centerTitle: false,
            iconTheme: const IconThemeData(
              color: kPrimaryColor,
            ),
            title: const Text(
              'นโยบายความเป็นส่วนตัว',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Html(
                data: htmlData,
              ),
            ),
          ),
          bottomNavigationBar: controller.hideButton ? null : BottomNaviTOS(),
        );
      },
    );
  }
}
