import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? id;
  late String? username;
  late String? email;
  late String? phone;
  late String? password;
  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  UserModel.defaultModel() {
    id = null;
    username = 'Default username';
    email = 'default@example.com';
    phone = '233################';
    password = 'Default Password';
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      username: map['username'],
      phone: map['phone'],
      password: map['password'],
    );
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.exists) {
      final data = document.data()!;
      return UserModel(
        id: FirebaseAuth.instance.currentUser!.uid,
        username: data['username'],
        email: data['email'],
        phone: data['phone'],
        password: data['password'],
      );
    } else {
      print('Document not found for id: ${document.id}');
      return UserModel.defaultModel();
    }
  }
}
