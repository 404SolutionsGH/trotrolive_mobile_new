import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trotrolive_mobile_new/repository/cache/station_cache_helper.dart';
import '../components/auth_exception.dart';
import '../repository/create_account_helper.dart';
import '../repository/data model/user_model.dart';
import '../repository/user_helper.dart';
import 'package:flutter/services.dart';

part 'auth_events.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  String imageUrl = '';

  AuthBloc() : super(AuthInitial()) {
    on<AppStartedEvent>(onAppStarted);
    on<SignupEvent>(registerUser);
    on<LoginEvent>(loginUser);
    on<ForgotPasswordEvent>(resetPassword);
    on<LogoutEvent>(logoutUser);
    on<CurrentUserEvent>(currentUser);
  }

  Future<void> onAppStarted(
      AppStartedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');
    debugPrint('Token retrieved on app start: $token');

    if (token != null && token.isNotEmpty) {
      debugPrint('User is logged in with token: $token');

      if (!emit.isDone) {
        emit(AuthenticatedState(message: 'Signup Succesful!!'));
      }
    } else {
      debugPrint('No token found, navigating to login.');
      if (!emit.isDone) {
        emit(UnAuthenticatedState());
      }
    }
  }

  Future<void> registerUser(SignupEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());

      await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      final user = UserModel(
        id: UserHelper.firebaseUser!.uid,
        username: event.username,
        phone: event.phone,
        email: event.email,
        password: event.password,
      );

      await AccountHelper.createUser(user);

      emit(AuthenticatedState(message: 'Account Created Successfully!!'));
      debugPrint('Account Created Successfully!!');

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', _auth.currentUser!.uid);

      debugPrint('AuthToken saved locally.');
      debugPrint('AuthToken saved: ${_auth.currentUser!.uid}');
    } on FirebaseAuthException catch (error) {
      final exception =
          SignUpWithEmailAndPasswordFailure(error.message.toString());
      emit(AuthFailureState(errorMessage: exception.message));
      debugPrint(exception.message);
    } catch (e) {
      emit(AuthFailureState(errorMessage: 'Error: ${e.toString()}'));
      debugPrint('Error:${e.toString()}');
    }
  }

  Future<void> loginUser(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());

      await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(AuthenticatedState(message: 'Login Succesful!!'));
      debugPrint('Login Succesful!!');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', _auth.currentUser!.uid);

      debugPrint('AuthToken saved locally.');
      debugPrint('AuthToken saved: ${_auth.currentUser!.uid}');
    } on FirebaseAuthException catch (error) {
      final exception = SignUpWithEmailAndPasswordFailure(error.code);
      emit(AuthFailureState(errorMessage: exception.message));
      debugPrint("Firebase auth exception ${exception.message}");
    } catch (e) {
      emit(AuthFailureState(errorMessage: e.toString()));
      debugPrint('Error:${e.toString()}');
    }
  }

  Future<void> resetPassword(
      ForgotPasswordEvent event, Emitter<AuthState> emit) async {}

  Future<void> logoutUser(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());

      await _auth.signOut();
      // await GoogleSignIn().signOut();

      emit(AuthLogoutSuccesState(message: 'User Logged out Succesfuly!!'));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('authToken');
      StationCacheHelper.clearCache();

      debugPrint('User Logged out Succesfuly!!');
      debugPrint('AuthToken removed !!');
    } on FirebaseAuthException catch (e) {
      emit(AuthLogoutFailureState(error: e.message.toString()));
      debugPrint('Logout Failed:${e.message}');
      throw e.message!;
    } on FormatException catch (e) {
      emit(AuthLogoutFailureState(error: e.message));
      debugPrint('Logout Failed:${e.message}');
      throw e.message;
    } catch (e) {
      emit(AuthLogoutFailureState(error: e.toString()));
      debugPrint('Logout Failed:$e');
      throw 'Unable to Logout. Try again';
    }
  }

  Future<void> currentUser(
      CurrentUserEvent event, Emitter<AuthState> emit) async {
    try {
      UserModel? userData;
      emit(UserLoadingState());
      debugPrint("Loading current user..");

      if (event.userId.isNotEmpty) {
        userData = await UserHelper.getCurrentUser(event.userId);
        emit(CurrentUserState(userData));
        debugPrint("Current user:$userData");
      } else {
        emit(UserLoadingFailState("Current user fetch fail.."));
      }
    } catch (e) {
      emit(UserLoadingFailState(e.toString()));
      debugPrint(e.toString());
    }
  }
}
