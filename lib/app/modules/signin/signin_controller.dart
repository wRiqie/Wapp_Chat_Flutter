import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wapp_chat/app/data/repository/admin_repository.dart';
import 'package:wapp_chat/app/data/repository/auth_repository.dart';
import 'package:wapp_chat/app/routes/app_pages.dart';
import 'package:connectivity/connectivity.dart';

class SignInController extends GetxController {
  final _authRepository = AuthRepository();
  final _adminRepository = AdminRepository();

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rx<bool> isStretched = true.obs;
  Rx<bool> isDone = false.obs;

  Rx<bool> showPassword = false.obs;

  onSuccess() async {
    isDone.value = true;
    await Future.delayed(const Duration(seconds: 2));
    Get.offAndToNamed(Routes.HOME);
  }

  onFailed() {
    isStretched.value = true;
    Get.rawSnackbar(
        message: 'Email e/ou senha incorretos',
        backgroundColor: Colors.redAccent);
  }

  show() {
    showPassword.value = !showPassword.value;
  }

  login() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isStretched.value = false;
      await _authRepository.signIn(
          email: emailController.text,
          password: passwordController.text,
          onSuccess: onSuccess,
          onFailed: onFailed);
    } else {
      Get.rawSnackbar(message: 'É necessário estar conectado à internet');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
