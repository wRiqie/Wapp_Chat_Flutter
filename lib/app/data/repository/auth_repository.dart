import 'package:flutter/cupertino.dart';
import 'package:wapp_chat/app/data/provider/firebase_provider.dart';

class AuthRepository {
  final firebase = FirebaseProvider();

  AuthRepository();

  Future signIn(
          {required String email,
          required String password,
          required VoidCallback onSuccess,
          required VoidCallback onFailed}) =>
      firebase.signIn(
          email: email,
          password: password,
          onSuccess: onSuccess,
          onFailed: onFailed);

  Future signUp(
          {required Map<String, dynamic> userData,
          required String password,
          required VoidCallback onSuccess,
          required VoidCallback onFailed}) =>
      firebase.signUp(
          userData: userData,
          password: password,
          onSuccess: onSuccess,
          onFailed: onFailed);

  logout()
    => firebase.signOut();

  recoverPass(String email) 
    => firebase.recoverPass(email);
}
