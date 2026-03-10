part of 'auth_form_bloc.dart';

@immutable
sealed class AuthFormEvent {}

class LoginEvent extends AuthFormEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class SignupEvent extends AuthFormEvent {
  final String email;
  final String password;

  SignupEvent(this.email, this.password);
}
