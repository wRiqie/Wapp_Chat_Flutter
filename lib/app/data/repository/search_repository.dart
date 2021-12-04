import 'package:wapp_chat/app/data/models/suggestion_model.dart';
import 'package:wapp_chat/app/data/models/user_model.dart';
import 'package:wapp_chat/app/data/provider/database_provider.dart';
import 'package:wapp_chat/app/data/provider/firebase_provider.dart';

class SearchRepository {
  final firebase = FirebaseProvider();
  final db = DatabaseProvider.db;

  SearchRepository();

  Future<List<UserModel>> searchUsers(String query) async
    => await firebase.searchUsersByName(query);

  // getSuggestions() async
  //   => await db.getSuggestions();

  // Future saveSuggestion(SuggestionModel suggestion) async
  //   => await db.saveSuggestion(suggestion);

  // Future deleteSuggestion(int id) async
  //   => await db.deleteSuggestion(id);

  // Future deleteSuggestions() async
  //   => await db.deleteSuggestions();
}
