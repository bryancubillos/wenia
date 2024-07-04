part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

class DoLogin extends LoginEvent {
  final String accountName;
  final String password;

  const DoLogin(this.accountName, this.password);
}

class DoNotifyRegistrerSuccess extends LoginEvent {
  const DoNotifyRegistrerSuccess();
}