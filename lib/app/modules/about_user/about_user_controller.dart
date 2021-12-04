import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wapp_chat/app/data/models/user_model.dart';
import 'package:wapp_chat/app/data/repository/friend_repository.dart';
import 'package:wapp_chat/app/data/repository/photo_repository.dart';
import 'package:wapp_chat/app/data/repository/user_repository.dart';

class AboutUserController extends GetxController {
  final _userRepository = UserRepository();
  final _friendRepository = FriendRepository();
  final _photoRepository = PhotoRepository();

  final _prefsInstance = SharedPreferences.getInstance();
  final user = Get.arguments;

  RxBool adicionado = false.obs;
  RxBool isLoading = false.obs;

  addFriend() async {
    isLoading.value = true;
    UserModel friend = UserModel(
      id: user['id'],
      name: user['name'],
      email: '',
      photo: '',
      photoUrl: user['photoUrl'],
      status: user['status'],
    );

    if (await _friendRepository.addFriend(friend)) {
      if (friend.photoUrl != '') {
        friend.photo = await _photoRepository.getNetworkImage(friend.photoUrl);
      }
      _userRepository.saveUser(friend);
      adicionado.value = true;
    } else {
      Get.rawSnackbar(message: 'Infelizmente ocorreu um erro, tente novamente');
      adicionado.value = false;
    }

    isLoading.value = false;
  }

  loadUser() async {
    var userFriend = await _userRepository.getUser(user['id']);
    if(userFriend != null){
      adicionado.value = true;
    }
  }

  @override
  void onInit() {
    super.onInit();

    loadUser();
  }
}
