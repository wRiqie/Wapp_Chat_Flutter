import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wapp_chat/app/core/theme/color_theme.dart';
import 'package:wapp_chat/app/modules/signup/signup_controller.dart';
import 'package:wapp_chat/app/routes/app_pages.dart';

class SignUpPage extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: primaryDark,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Criar Conta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Por favor preencha os campos abaixo',
                    style: TextStyle(
                      color: primaryLight,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: controller.formKey,
                    child: Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(16),
                        children: [
                          TextFormField(
                            controller: controller.nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: primaryLight,
                              ),
                              label: Text('Nome Completo'),
                              labelStyle:
                                  TextStyle(color: primaryLight, fontSize: 14),
                            ),
                            style: const TextStyle(color: Colors.white),
                            validator: (text) {
                              if (text != null) {
                                if (text.isEmpty) {
                                  return 'Por favor, insira um nome';
                                }
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: primaryLight,
                              ),
                              label: Text('Email'),
                              labelStyle:
                                  TextStyle(color: primaryLight, fontSize: 14),
                            ),
                            style: const TextStyle(color: Colors.white),
                            validator: (text) {
                              if (text != null) {
                                if (text.isEmpty) {
                                  return 'Por favor, insira um email';
                                } else if (!text.isEmail) {
                                  return 'Por favor, insira um email válido';
                                }
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => TextFormField(
                              controller: controller.passwordController,
                              obscureText: !controller.showPassword.value,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: controller.show,
                                  icon: Icon(
                                    controller.showPassword.value
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_rounded,
                                    color: primaryLight,
                                  ),
                                ),
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: primaryLight,
                                ),
                                label: const Text('Senha'),
                                labelStyle: const TextStyle(
                                    color: primaryLight, fontSize: 14),
                              ),
                              style: const TextStyle(color: Colors.white),
                              validator: (text) {
                                if (text != null) {
                                  if (text.isEmpty) {
                                    return 'Por favor, insira uma senha';
                                  } else if (text.length < 6) {
                                    return 'A senha de ter ao menos 6 dígitos';
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() => TextFormField(
                              controller: controller.rePasswordController,
                              obscureText: !controller.showPassword.value,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: controller.show,
                                  icon: Icon(
                                    controller.showPassword.value
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_rounded,
                                    color: primaryLight,
                                  ),
                                ),
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: primaryLight,
                                ),
                                label: const Text('Confirmar Senha'),
                                labelStyle: const TextStyle(
                                    color: primaryLight, fontSize: 14),
                              ),
                              style: const TextStyle(color: Colors.white),
                              validator: (text) {
                                if (text != null) {
                                  if (text.isEmpty) {
                                    return 'Por favor, confirme sua senha';
                                  } else if (text !=
                                      controller.passwordController.text) {
                                    return 'As senhas não conferem';
                                  }
                                }
                              })),
                          const SizedBox(
                            height: 50,
                          ),
                          Obx(() => AnimatedContainer(
                                duration: const Duration(seconds: 3),
                                curve: Curves.easeIn,
                                width:
                                    controller.isStretched.value ? width : 60,
                                height: 60,
                                child: controller.isStretched.value
                                    ? buildButton(context)
                                    : buildSmallButton(controller.isDone),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: const Divider(
                              color: primaryLight,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Já possui uma conta? ',
                                style: TextStyle(color: primaryLight),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.offAndToNamed(Routes.LOGIN);
                                },
                                child: Text(
                                  'Entrar',
                                  style: TextStyle(color: secondaryLight),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (controller.formKey.currentState!.validate()) {
          FocusScope.of(context).requestFocus(FocusNode());
          controller.signUp();
        }
      },
      child: const Text(
        'Criar Conta',
        style: TextStyle(color: primaryDark),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(secondaryLight),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ))),
    );
  }

  Widget buildSmallButton(isDone) {
    final color = isDone == true ? Colors.green : secondaryLight;

    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: isDone == true
          ? const Icon(
              Icons.done,
              size: 32,
              color: Colors.white,
            )
          : const Center(
              child: CircularProgressIndicator(
                color: secondaryDark,
              ),
            ),
    );
  }
}
