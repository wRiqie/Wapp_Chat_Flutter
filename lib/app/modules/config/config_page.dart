import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wapp_chat/app/core/theme/color_theme.dart';
import 'package:wapp_chat/app/core/utils/utility.dart';
import 'package:wapp_chat/app/modules/config/config_controller.dart';
import 'package:wapp_chat/app/modules/config/widgets/build_sections.dart';
import 'package:wapp_chat/app/routes/app_pages.dart';

class ConfigPage extends GetView<ConfigController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: const Text('Configurações'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            color: primaryDark,
            height: size.height * 0.20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                width: size.width * 0.9,
                height: 360,
                child: Card(
                    elevation: 20,
                    color: primary,
                    child: GetBuilder<ConfigController>(
                      init: ConfigController(),
                      builder: (_) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () async {
                                  await Get.toNamed(Routes.PROFILE);
                                  controller.reloadUser();
                                },
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  color: primaryLight,
                                ),
                              ),
                            ),
                            Hero(
                              tag: 'dash',
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: controller.user?.photo != '' &&
                                        controller.user?.photo != null
                                    ? ClipOval(
                                        child: Utility.imageFromBase64String(
                                            controller.user?.photo ?? ''),
                                      )
                                    : const Icon(
                                        Icons.person,
                                        color: primaryDark,
                                        size: 60,
                                      ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.user?.name ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              controller.user?.status ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: light,
                              ),
                            )
                          ],
                        );
                      },
                    )),
              ),
              Expanded(
                child: ListView(
                  children: [
                    BuildSections(
                      icon: const Icon(Icons.dashboard_outlined,
                          size: 30, color: primaryLight),
                      title: 'Meu status',
                      func: () {},
                    ),
                    BuildSections(
                      icon: const Icon(Icons.chat_outlined,
                          size: 30, color: primaryLight),
                      title: 'Conversas',
                      func: () {},
                    ),
                    BuildSections(
                      icon: const Icon(
                        Icons.exit_to_app_outlined,
                        size: 30,
                        color: primaryLight,
                      ),
                      title: 'Sair',
                      func: () {
                        controller.signOut();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
