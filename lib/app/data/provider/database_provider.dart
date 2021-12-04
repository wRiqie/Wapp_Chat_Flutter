import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wapp_chat/app/data/models/admin_model.dart';
import 'package:wapp_chat/app/data/models/friends_model.dart';
import 'package:wapp_chat/app/data/models/suggestion_model.dart';
import 'package:wapp_chat/app/data/models/user_model.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'wapp.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {
        await db.execute(_createTables());
      },
      onCreate: (Database db, int version) async {},
    );
  }

  static const userTable = 'user';
  static const userId = 'id';
  static const userName = 'name';
  static const userEmail = 'email';
  static const userPhoto = 'photo';
  static const userPhotoUrl = 'photoUrl';
  static const userStatus = 'status';

  saveUser(UserModel user) async {
    final db = await database;
    if (db != null) {
      var res = await db.insert(userTable, user.toJson());
      return res;
    }
  }

  Future<UserModel?> getUser(String id) async {
    final db = await database;
    if (db != null) {
      var res = await db.query(userTable, where: 'id = ?', whereArgs: [id]);
      return res.isNotEmpty ? UserModel.fromJson(res.first) : null;
    }
  }

  getUsers() async {
    final db = await database;
    if (db != null) {
      var res = await db.query(userTable);
      List<UserModel> users = res.isNotEmpty
          ? res.map((user) => UserModel.fromJson(user)).toList()
          : [];
      return users;
    }
  }

  updateUser(UserModel user) async {
    final db = await database;
    if (db != null) {
      var res = await db.update(userTable, user.toJson(),
          where: 'id = ?', whereArgs: [user.id]);
      return res;
    }
  }

  deleteUser(String id) async {
    final db = await database;
    if (db != null) {
      db.rawDelete('Delete from $userTable WHERE $userId = "$id"');
    }
  }

  deleteUsers() async {
    final db = await database;
    if (db != null) {
      db.rawDelete('Delete from $userTable');
    }
  }

  // Admin
  static const adminTable = 'admin';
  static const adminId = 'id';

  saveAdmin(AdminModel adm) async {
    final db = await database;
    if (db != null) {
      var res = db.insert(adminTable, adm.toJson());
      return res;
    }
  }

  Future<List<AdminModel>> getAdmins() async {
    final db = await database;
    if (db != null) {
      var res = await db.query(adminTable);
      List<AdminModel> users = res.isNotEmpty
          ? res.map((admin) => AdminModel.fromJson(admin)).toList()
          : [];
      return users;
    }
    return [];
  }

  // Friends
  static const friendsTable = 'friend';
  static const friendsId = 'id';
  static const friendsLoggedUserId = 'loggedUserId';
  static const friendsChatId = 'chatId';
  static const friendsName = 'name';
  static const friendsPhoto = 'photo';
  static const friendsPhotoUrl = 'photoUrl';
  static const friendsStatus = 'status';

  saveFriend(FriendsModel friend) async {
    var db = await database;
    if (db != null) {
      var res = db.insert(friendsTable, friend.toJson());
      return res;
    }
  }

  getFriends(String userId) async {
    var db = await database;
    if (db != null) {
      var res =
          await db.query(friendsTable, where: 'id = ?', whereArgs: [userId]);
      List<FriendsModel> friends = res.isNotEmpty
          ? res.map((friend) => FriendsModel.fromJson(friend)).toList()
          : [];

      return friends;
    }
  }

  removeFriends(String userId) async {
    var db = await database;
    if (db != null) {
      var res = await db.rawDelete(
          'DELETE FROM $friendsTable WHERE $friendsLoggedUserId = $userId');
      return res;
    }
  }

  // Suggestions
  // static const suggestionsTable = 'suggestion';
  // static const suggestionsId = 'id';
  // static const suggestionsName = 'name';

  // saveSuggestion(SuggestionModel suggestion) async {
  //   var db = await database;
  //   if (db != null) {
  //     var res = await db.insert(suggestionsTable, suggestion.toJson());
  //     return res;
  //   }
  // }

  // getSuggestions() async {
  //   var db = await database;
  //   if (db != null) {
  //     var res = await db.query(suggestionsTable);
  //     List<SuggestionModel> suggestions = res.isNotEmpty
  //         ? res
  //             .map((suggestion) => SuggestionModel.fromJson(suggestion))
  //             .toList()
  //         : [];
      
  //     return suggestions;
  //   }
  // }

  // deleteSuggestion(int id) async {
  //   var db = await database;
  //   if (db != null) {
  //     var res = db.rawDelete('DELETE FROM $suggestionsTable WHERE $suggestionsId = $id');
  //     return res;
  //   }
  // }

  // deleteSuggestions() async {
  //   var db = await database;
  //   if (db != null) {
  //     var res = db.rawDelete('DELETE FROM $suggestionsTable');
  //     return res;
  //   }
  // }

  String _createTables() {
    return """
      --Table User
      CREATE TABLE IF NOT EXISTS $userTable (
        $userId TEXT PRIMARY KEY,
        $userName TEXT,
        $userEmail TEXT,
        $userPhoto TEXT,
        $userPhotoUrl TEXT,
        $userStatus TEXT
      );

      --Table Admin
      CREATE TABLE IF NOT EXISTS $adminTable (
        $adminId TEXT PRIMARY KEY
      );

      --Table Friends
      CREATE TABLE IF NOT EXISTS $friendsTable (
        $friendsId TEXT PRIMARY KEY,
        $friendsLoggedUserId TEXT,
        $friendsChatId TEXT,
        $friendsName TEXT,
        $friendsPhoto TEXT,
        $friendsPhotoUrl TEXT,
        $friendsStatus TEXT
      );

      
    """;
  }
}

// Table Suggestions
//       CREATE TABLE IF NOT EXISTS $suggestionsTable (
//         $suggestionsId TEXT PRIMARY KEY,
//         $suggestionsName TEXT
//       );
