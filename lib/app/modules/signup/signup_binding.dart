import 'package:get/get.dart';
import 'package:wapp_chat/app/modules/signup/signup_controller.dart';

class SignUpBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<SignUpController>(() => SignUpController());
  }
}