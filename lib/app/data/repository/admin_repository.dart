import 'package:wapp_chat/app/data/models/admin_model.dart';
import 'package:wapp_chat/app/data/provider/database_provider.dart';
import 'package:wapp_chat/app/data/provider/firebase_provider.dart';

class AdminRepository {
  final db = DatabaseProvider.db;
  final firebase = FirebaseProvider();

  AdminRepository();

  Future<List<AdminModel>> getAdmins() async
    => await firebase.getAdmins();

  deleteUserFromDatabase(String userId) async 
    => await db.deleteUser(userId);
}
