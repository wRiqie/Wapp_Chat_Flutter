import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wapp_chat/app/core/theme/color_theme.dart';
import 'package:wapp_chat/app/core/utils/utility.dart';
import 'package:wapp_chat/app/modules/profile/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: GetBuilder<ProfileController>(
            init: ProfileController(),
            initState: (_) {},
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 5,),
                  controller.isLoading.value ? Center(child: CircularProgressIndicator(color: primaryDark,)) : Container(),
                  const SizedBox(
                    height: 25,
                  ),
                  Hero(
                    tag: 'dash',
                    child: GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                          title: 'Foto de perfil',
                          content: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  controller.swapPhoto();
                                  Get.back();
                                },
                                child: const Text(
                                  'Trocar foto',
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryDark),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                  controller.removePhoto();
                                },
                                child: const Text(
                                  'Remover foto',
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryDark),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: controller.user?.photo != '' &&
                                controller.user?.photo != null
                            ? ClipOval(
                                child: Utility.imageFromBase64String(
                                    controller.user?.photo ?? ''))
                            : const Icon(
                                Icons.person,
                                color: primaryDark,
                                size: 80,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outlined,
                        size: 30,
                        color: primaryLight,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nome',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            controller.user?.name ?? '',
                            style: const TextStyle(color: primaryLight),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: primaryLight,
                          ))
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Divider(
                      color: primaryLight,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 30,
                        color: primaryLight,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recado',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            controller.user?.status ?? '',
                            style: const TextStyle(color: primaryLight),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: primaryLight,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          )),
    );
  }
}
