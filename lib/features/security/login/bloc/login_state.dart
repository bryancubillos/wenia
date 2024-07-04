part of 'login_bloc.dart';

sealed class LoginState {
  const LoginState();
}

// [Life cicle]
final class LoginInitial extends LoginState {}

// [States]
final class LoginLoading extends LoginState {}

final class LoginLoaded extends LoginState {
  final String message;
  
  LoginLoaded(this.message);
}

final class LoginSuccess extends LoginState {
  final User? userLogin;

  LoginSuccess(this.userLogin);
}

final class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}