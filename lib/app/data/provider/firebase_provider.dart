import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wapp_chat/app/data/models/admin_model.dart';
import 'package:wapp_chat/app/data/models/friends_model.dart';
import 'package:wapp_chat/app/data/models/user_model.dart';
import 'package:wapp_chat/app/data/repository/user_repository.dart';
import 'package:uuid/uuid.dart';

class FirebaseProvider {
  final _userRepository = UserRepository();
  final _prefsInstance = SharedPreferences.getInstance();
  final _auth = FirebaseAuth.instance;
  User? firebaseUser;

  FirebaseProvider();
  final uid = const Uuid();

  getUserId() async {
    var prefs = await _prefsInstance;
    var id = prefs.getString('userId');
    return id;
  }

  // Auth
  signUp(
      {required Map<String, dynamic> userData,
      required String password,
      required VoidCallback onSuccess,
      required VoidCallback onFailed}) async {
    try {
      // Criar user
      var user = await _auth.createUserWithEmailAndPassword(
          email: userData['email'], password: password);
      firebaseUser = user.user;

      // Salvar userId
      var prefs = await _prefsInstance;
      prefs.setString('userId', firebaseUser!.uid);

      // Salvar user no firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser!.uid)
          .set(userData);

      // Salvar user no sqflite
      var userModel = UserModel(
        id: firebaseUser!.uid,
        name: userData['name'],
        email: userData['email'],
        photo: '',
        photoUrl: userData['photoUrl'],
        status: userData['status'],
      );

      await _userRepository.saveUser(userModel);

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFailed();
      print(e.message);
    } catch (err) {
      onFailed();
      print(err);
    }
  }

  signIn(
      {required String email,
      required String password,
      required VoidCallback onSuccess,
      required VoidCallback onFailed}) async {
    try {
      // Logar user
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      firebaseUser = user.user;

      // Salvar userId
      var prefs = await _prefsInstance;
      prefs.setString('userId', firebaseUser!.uid);

      // Recuperar dados do firestore
      var userFirestore = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser!.uid)
          .get();

      // Recuperar imagem
      var img = '';
      if (userFirestore.get('photoUrl') != '') {
        img = await networkImageToBase64(userFirestore.get('photoUrl'));
      }

      // Salvar user no sqflite
      var userModel = UserModel(
          id: firebaseUser!.uid,
          name: userFirestore.get('name'),
          email: userFirestore.get('email'),
          photo: img,
          photoUrl: userFirestore.get('photoUrl'),
          status: userFirestore.get('status'),
        );

      var userSaved = await _userRepository.getUser(firebaseUser!.uid);
      if (userSaved == null) {
        await _userRepository.saveUser(userModel);
      }
      else{
        await _userRepository.updateUser(userModel);
      }

      onSuccess();
    } on FirebaseAuthException catch (e) {
      print(e.message);
      onFailed();
    }
  }

  signOut() async {
    await _auth.signOut();
    var prefs = await _prefsInstance;
    await _userRepository.deleteUser(prefs.getString('userId').toString());
    prefs.remove('userId');
    firebaseUser = null;
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  // Storage
  Future saveProfilePhoto(
      {required String userId, required File imgFile}) async {
    TaskSnapshot task = await FirebaseStorage.instance
        .ref()
        .child(userId)
        .child('Profile_Photo')
        .putFile(imgFile);

    String url = await task.ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'photoUrl': url});

    return url;
  }

  Future removeProfilePhoto(String userId) async {
    // Deletar do storage
    await FirebaseStorage.instance
        .ref()
        .child(userId)
        .child('Profile_Photo')
        .delete();
    // Deletar url do firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'photoUrl': ''});

    // Remover foto do sqflite
    var prefs = await _prefsInstance;
    var userModel =
        await _userRepository.getUser(prefs.getString('userId').toString());

    if (userModel != null) {
      userModel.photoUrl = '';
      userModel.photo = '';

      await _userRepository.updateUser(userModel);
    }
  }

  Future swapPhoto() async {
    // Conseguir foto
    const source = ImageSource.gallery;
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      var profilePhoto = await cropSquareImage(file);

      List<int> imagebytes = profilePhoto.readAsBytesSync();
      String base64Image = base64Encode(imagebytes);

      // Salvar foto sqflite e firebase
      var prefs = await _prefsInstance;
      var userModel =
          await _userRepository.getUser(prefs.getString('userId').toString());
      if (userModel != null) {
        await saveProfilePhoto(userId: userModel.id, imgFile: file);
        userModel.photo = base64Image;
        _userRepository.updateUser(userModel);

        return base64Image;
      }
    }
  }

  Future<File> cropSquareImage(File image) async {
    var croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square]);

    if (croppedImage != null) {
      return croppedImage;
    } else {
      return image;
    }
  }

  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return base64Encode(bytes);
  }

  // Search
  Future<List<UserModel>> searchUsersByName(String query) async {
    var id = await getUserId();
    List<UserModel> usersList = [];
    QuerySnapshot usersFilteredList = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .get();
    usersList = usersFilteredList.docs
        .map<UserModel>((user) => UserModel.fromDocument(user))
        .toList();
    usersList.removeWhere((x) => x.id == id);
    return usersList;
  }

  // Friend
  Future<bool> addFriend(UserModel friend) async {
    try {
      // Recuperar usuário atual
      var id = await getUserId();
      UserModel? loggedUser = await _userRepository.getUser(id);

      var chatId = uid.v1();

      if (loggedUser != null) {
        //Salvar amigo na collection do usuario logado
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .collection('friends')
            .doc(friend.id)
            .set(({
              'id': friend.id,
              'name': friend.name,
              'status': friend.status,
              'photoUrl': friend.photoUrl,
              'chatId': chatId
            }));

        //Salvar usuario logado na collection do amigo
        await FirebaseFirestore.instance
            .collection('users')
            .doc(friend.id)
            .collection('friends')
            .doc(id)
            .set(({
              'id': loggedUser.id,
              'name': loggedUser.name,
              'status': loggedUser.status,
              'photoUrl': loggedUser.photoUrl,
              'chatId': chatId
            }));

        // Criar Chat
        // await FirebaseFirestore.instance.collection('chats').doc(chatId).set({});
        return true;
      }

      return false;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<List<FriendsModel>> getFriends() async {
    var id = await getUserId();

    List<FriendsModel> friendsList = [];

    var friends = await FirebaseFirestore.instance.collection('users').doc(id).collection('friends').get();
    friends.docs.map((e) async {
      var f = FriendsModel(
          id: e.get('id'),
          chatId: e.get('chatId'),
          loggedUserId: e.get('loggedUserId'),
          name: e.get('name'),
          photo: '',
          photoUrl: e.get('photoUrl'),
          status: e.get('status')
      );
      
      if(f.photoUrl.isNotEmpty){
        f.photo = await networkImageToBase64(f.photoUrl);
      }
      friendsList.add(f);
    });

    return friendsList;
  }

  // Chat

  // Admin
  Future<List<AdminModel>> getAdmins() async {
    var id = await getUserId();

    List<AdminModel> listAdmins = [];

    var admins = await FirebaseFirestore.instance.collection('admins').get();
    admins.docs
        .map((e) => listAdmins.add(AdminModel(id: e.get('id'))))
        .toList();

    return listAdmins;
  }
}
