import 'package:get/get.dart';
import 'package:wapp_chat/app/modules/admin/admin_controller.dart';

class AdminBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<AdminController>(() => AdminController());
  }
}