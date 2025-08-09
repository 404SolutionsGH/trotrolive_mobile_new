import 'data model/user_model.dart';
import 'user_helper.dart';

class AccountHelper {
  static final UserHelper _userHelper = UserHelper();

  static Future<void> createUser(UserModel user) async {
    try {
      final existingUser = await _userHelper.getUserByEmail(user.email);

      if (existingUser == null) {
        print("No existing user found. Creating new user.");

        await _userHelper.createUserDb(user);
        print("User created successfully in Firestore.");
      } else {
        print("User already exists with email: ${existingUser.email}");
        throw Exception('User with this email already exists');
      }
    } catch (error) {
      print("Error creating user: $error");
      rethrow;
    }
  }
}
