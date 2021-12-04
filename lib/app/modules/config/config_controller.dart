import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wapp_chat/app/data/models/user_model.dart';
import 'package:wapp_chat/app/data/repository/auth_repository.dart';
import 'package:wapp_chat/app/data/repository/user_repository.dart';
import 'package:wapp_chat/app/routes/app_pages.dart';

class ConfigController extends GetxController {
  final _authRepository = AuthRepository();
  final _userRepository = UserRepository();
  final _prefsInstance = SharedPreferences.getInstance();

  UserModel? user;
  late SharedPreferences prefs;

  signOut() async {
    await _authRepository.logout();
    Get.offAllNamed(Routes.LOGIN);
  }

  reloadUser() async {
    var id = prefs.getString('userId');
    user = await _userRepository.getUser(id.toString());
    update();
  }

  @override
  void onInit() async {
    super.onInit();

    prefs = await _prefsInstance;
    var id = prefs.getString('userId');
    user = await _userRepository.getUser(id.toString());
    update();
  }
}