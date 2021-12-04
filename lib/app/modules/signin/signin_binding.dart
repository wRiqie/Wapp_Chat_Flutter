import 'package:get/get.dart';
import 'package:wapp_chat/app/modules/signin/signin_controller.dart';

class SignInBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<SignInController>(() => SignInController());
  }
}