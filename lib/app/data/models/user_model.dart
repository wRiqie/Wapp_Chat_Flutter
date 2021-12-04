import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String id;
  late String name;
  String? email;
  late String photo;
  late String photoUrl;
  late String status;

  UserModel(
      {required this.id,
      required this.name,
      required this.photo,
      required this.photoUrl,
      this.email,
      required this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    photoUrl = json['photoUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['photo'] = photo;
    data['photoUrl'] = photoUrl;
    data['status'] = status;
    return data;
  }

  UserModel.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.get('name');
    email = document.get('email');
    photo = '';
    photoUrl = document.get('photoUrl');
    status = document.get('status');
  }
}
