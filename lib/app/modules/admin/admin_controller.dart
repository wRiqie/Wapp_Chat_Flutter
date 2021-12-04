import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wapp_chat/app/data/repository/admin_repository.dart';
import 'package:wapp_chat/app/data/repository/user_repository.dart';

class AdminController extends GetxController {
  final _adminRepository = AdminRepository();
  final _userRepository = UserRepository();

  TextEditingController idController = TextEditingController();

  deleteUser() async {
    var user = await _userRepository.getUser(idController.text);

    if (user != null) {
      await _adminRepository.deleteUserFromDatabase(idController.text);
      Get.rawSnackbar(message: 'Usuário ${user.name} deletado com sucesso');
    }
    else{
      Get.rawSnackbar(message: 'Usuário não encontrado...');
    }
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
  }
}
