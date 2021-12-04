import 'dart:io';
import 'package:wapp_chat/app/data/models/user_model.dart';
import 'package:wapp_chat/app/data/provider/database_provider.dart';
import 'package:wapp_chat/app/data/provider/firebase_provider.dart';

class UserRepository {
  final db = DatabaseProvider.db;

  UserRepository();

  Future<UserModel?> getUser(String id) async
    => await db.getUser(id);

  getUsers() async
    => await db.getUsers();

  saveUser(UserModel user) async
    => await db.saveUser(user);

  updateUser(UserModel user) async
    => await db.updateUser(user);

  deleteUser(String userId) async
    => await db.deleteUser(userId);
}
