import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wapp_chat/app/core/theme/color_theme.dart';
import 'package:wapp_chat/app/core/utils/utility.dart';
import 'package:wapp_chat/app/modules/about_user/about_user_controller.dart';

class AboutUserPage extends GetView<AboutUserController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryDark,
        elevation: 0,
      ),
      body: Column(
        children: [
          Obx(() => controller.isLoading.value ? LinearProgressIndicator() : Container()),
          Container(
            width: size.width,
            height: size.height * 0.3,
            color: primaryDark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,
                  child: controller.user['photoUrl'] != ''
                      ? ClipOval(
                          child: Image.network(
                            controller.user['photoUrl'],
                            fit: BoxFit.contain,
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          color: primaryDark,
                          size: 70,
                        ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  controller.user['name'],
                  style: const TextStyle(
                      color: light, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.coffee,
                      color: light,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      controller.user['status'],
                      style: const TextStyle(color: light),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: ListView(
              children: [
                Obx(() => ElevatedButton(
                      onPressed: controller.adicionado.value
                          ? () {
                              Get.rawSnackbar(
                                  message:
                                      '${controller.user['name']} é seu amigo!');
                            }
                          : controller.addFriend,
                      child: controller.adicionado.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.verified),
                                SizedBox(width: 5,),
                                Text(
                                  'Amigos',
                                ),
                              ],
                            )
                          : Text('Adicionar amigo'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primaryDark),
                      ),
                    )),
                const Text(
                  'Sobre Mim',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Olá meu nome é ${controller.user['name']}'),
                const SizedBox(
                  height: 5,
                ),
                const Divider(),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
