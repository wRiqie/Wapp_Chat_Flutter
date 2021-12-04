import 'package:wapp_chat/app/data/models/friends_model.dart';
import 'package:wapp_chat/app/data/models/user_model.dart';
import 'package:wapp_chat/app/data/provider/database_provider.dart';
import 'package:wapp_chat/app/data/provider/firebase_provider.dart';

class FriendRepository {
  final firebase = FirebaseProvider();
  final db = DatabaseProvider.db;

  FriendRepository();

  // From firebase
  Future<bool> addFriend(UserModel friend) async
    => await firebase.addFriend(friend);

  Future<List<FriendsModel>> getFriendsFromFirebase() async 
    => await firebase.getFriends();
    
  // From Sqflite
  saveFriend(FriendsModel friend) async
    => await db.saveFriend(friend);

  getFriends(String userId) async 
    => await db.getFriends(userId);

  removeFriends(String userId) async 
    => await db.removeFriends(userId);
}
