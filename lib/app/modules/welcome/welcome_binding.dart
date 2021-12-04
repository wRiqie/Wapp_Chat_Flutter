import 'package:get/get.dart';
import 'package:wapp_chat/app/modules/welcome/welcome_controller.dart';

class WelcomeBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}