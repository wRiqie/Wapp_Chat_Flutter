import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wapp_chat/app/core/theme/color_theme.dart';
import 'package:wapp_chat/app/modules/conversas/conversas_page.dart';
import 'package:wapp_chat/app/modules/tabs/tabs_controller.dart';
import 'package:wapp_chat/app/modules/tabs/widgets/search_widget.dart';
import 'package:wapp_chat/app/routes/app_pages.dart';

class TabsPage extends GetView<TabsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WApp Flutter', style: TextStyle(color: primaryLight),),
        bottom: TabBar(
          controller: controller.tabsController,
          indicatorColor: primaryLight,
          tabs: controller.tabs,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: const Icon(Icons.search, color: primaryLight,),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.CONFIG);
            },
            icon: const Icon(Icons.person, color: primaryLight),
          ),
        ],
      ),
      body: TabBarView(
        controller: controller.tabsController,
        children: [
          ConversasPage(),
          Container(
            color: primaryLight,
          ),
        ],
      ),
    );
  }
}
