import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsModel {
  late String id;
  late String loggedUserId;
  late String chatId;
  late String name;
  late String photo;
  late String photoUrl;
  late String status;

  FriendsModel(
      {required this.id,
      required this.loggedUserId,
      required this.chatId,
      required this.name,
      required this.photo,
      required this.photoUrl,
      required this.status});

  FriendsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loggedUserId = json['loggedUserId'];
    chatId = json['chatId'];
    name = json['name'];
    photo = json['photo'];
    photoUrl = json['photoUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['loggedUserId'] = loggedUserId;
    data['chatId'] = chatId;
    data['name'] = name;
    data['photo'] = photo;
    data['photoUrl'] = photoUrl;
    data['status'] = status;
    return data;
  }

  FriendsModel.fromDocument(DocumentSnapshot document){
    id = document.id;
    loggedUserId = document.get('loggedUserId');
    chatId = document.get('chatId');
    name = document.get('name');
    photo = '';
    photoUrl = document.get('photoUrl');
    status = document.get('status');
  }
}