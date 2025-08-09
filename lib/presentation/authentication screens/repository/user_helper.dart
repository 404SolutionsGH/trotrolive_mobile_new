import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'data model/user_model.dart';

class UserHelper {
  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;
  static final firebaseUser = FirebaseAuth.instance.currentUser;
  Future<void> createUserDb(UserModel userModel) async {
    try {
      final firebaseUser = _auth.currentUser;
      if (firebaseUser == null) throw Exception('No authenticated user');

      await _db.collection("users").doc(firebaseUser.uid).set({
        'id': firebaseUser.uid,
        'username': userModel.username,
        'email': userModel.email,
        'phone': userModel.phone,
      });
      print("Account created successfully");
    } catch (error) {
      print("Error creating user in Firestore: $error");
      rethrow;
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _db.collection("users").doc(userId).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc, null);
      }
      return null;
    } catch (error) {
      print('Error fetching user details: $error');
      rethrow;
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final snapshot = await _db
          .collection("users")
          .where("email", isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return UserModel.fromFirestore(snapshot.docs.first, null);
      }
      return null;
    } catch (error) {
      print('Error fetching user by email: $error');
      rethrow;
    }
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
