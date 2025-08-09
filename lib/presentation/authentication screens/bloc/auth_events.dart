part of 'auth_bloc.dart';

sealed class AuthEvents {}

class AppStartedEvent extends AuthEvents {}

class SignupEvent extends AuthEvents {
  String username;
  String phone;
  String email;
  String password;

  SignupEvent({
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
  });
}

class LoginEvent extends AuthEvents {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}

class LoginWithGoogleEvent extends AuthEvents {}

class LogoutEvent extends AuthEvents {}

class ForgotPasswordEvent extends AuthEvents {}

class PickImageEvent extends AuthEvents {}

class CurrentUserEvent extends AuthEvents {
  CurrentUserEvent();
}
