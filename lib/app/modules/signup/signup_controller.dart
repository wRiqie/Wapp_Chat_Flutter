import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wapp_chat/app/data/repository/admin_repository.dart';
import 'package:wapp_chat/app/data/repository/auth_repository.dart';
import 'package:wapp_chat/app/routes/app_pages.dart';

class SignUpController extends GetxController {
  final _authRepository = AuthRepository();
  final _adminRepository = AdminRepository();

  Rx<bool> isStretched = true.obs;
  Rx<bool> isDone = false.obs;

  Rx<bool> showPassword = false.obs;

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  onSuccess() async {
    isDone.value = true;
    await Future.delayed(const Duration(seconds: 2));
    Get.offAndToNamed(Routes.HOME);
  }

  onFailed() {
    isStretched.value = true;
    Get.rawSnackbar(
        message: 'Email já em uso', backgroundColor: Colors.redAccent);
  }

  signUp() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isStretched.value = false;
      Map<String, dynamic> userData = {
        'name': nameController.text,
        'email': emailController.text,
        'photoUrl': '',
        'status': 'Disponível',
      };

      _authRepository.signUp(
          userData: userData,
          password: passwordController.text,
          onSuccess: onSuccess,
          onFailed: onFailed);
    } else {
      Get.rawSnackbar(message: 'É necessário estar conectado à internet');
    }
  }

  show() {
    showPassword.value = !showPassword.value;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }
}
