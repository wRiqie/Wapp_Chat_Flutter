import 'package:get/get.dart';
import 'package:wapp_chat/app/modules/config/config_controller.dart';

class ConfigBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ConfigController>(() => ConfigController());
  }
}