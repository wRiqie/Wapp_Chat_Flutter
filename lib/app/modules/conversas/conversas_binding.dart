import 'package:get/get.dart';
import 'package:wapp_chat/app/modules/conversas/conversas_controller.dart';

class ConversasBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ConversasController>(() => ConversasController());
  }
}