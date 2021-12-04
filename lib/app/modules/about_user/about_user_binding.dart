import 'package:get/get.dart';
import 'package:wapp_chat/app/modules/about_user/about_user_controller.dart';

class AboutUserBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<AboutUserController>(() => AboutUserController());
  }
}