
import 'package:get/get.dart';
import '../controllers/edit_profile_text_field_controller.dart';


class EditProfileTextFieldBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileTextFieldController>(() => EditProfileTextFieldController());
        // Get.put<EditProfileTextFieldController>(EditProfileTextFieldController());
  }
}