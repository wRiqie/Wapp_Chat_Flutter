import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wapp_chat/app/data/models/user_model.dart';
import 'package:wapp_chat/app/data/repository/photo_repository.dart';
import 'package:wapp_chat/app/data/repository/user_repository.dart';

class ProfileController extends GetxController {
  final _userRepository = UserRepository();
  final _photoRepository = PhotoRepository();
  final _prefsInstance = SharedPreferences.getInstance();

  UserModel? user;
  late SharedPreferences prefs;

  RxBool isLoading = false.obs;

  swapPhoto() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      isLoading.value = true;
      update();
      var img = await _photoRepository.swapProfilePhoto();
      if (img != null) {
        if (user != null) {
          user!.photo = img;
          update();
        }
      }
      isLoading.value = false;
      update();
    }
    else{
      Get.rawSnackbar(message: 'Por favor, conecte-se a internet', backgroundColor: Colors.redAccent);
    }
  }

  removePhoto() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      if(user != null) {
        user!.photo = '';
        update();
        await _photoRepository.removeProfilePhoto(user!.id);
      }
    }
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
