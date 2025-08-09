import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String? phone;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
    };
  }

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) throw Exception('User data is null');

    return UserModel(
      id: data['id'] ?? snapshot.id,
      username: data['username'] ?? 'Unknown',
      email: data['email'] ?? '',
      phone: data['phone'],
    );
  }

  factory UserModel.empty() {
    return UserModel(
      id: '',
      username: 'Guest',
      email: '',
      phone: null,
    );
  }

  static Future<UserModel> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return UserModel.empty();
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        return UserModel.fromFirestore(doc, null);
      }
      return UserModel.empty();
    } catch (e) {
      print('Error fetching user: $e');
      return UserModel.empty();
    }
  }
}
