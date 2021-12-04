import 'package:get/get.dart';
import 'package:wapp_chat/app/modules/profile/profile_controller.dart';

class ProfileBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ProfileController>(() => ProfileController());
  }
}