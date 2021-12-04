import 'package:get/get.dart';
import 'package:wapp_chat/app/modules/conversas/conversas_controller.dart';
import 'package:wapp_chat/app/modules/tabs/tabs_controller.dart';

class TabsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(() => TabsController());
    Get.lazyPut<ConversasController>(() => ConversasController());
  }
}
