part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent {
  const ChangePasswordEvent();
}

class DoChangePassword extends ChangePasswordEvent {
  final String newPassword;

  const DoChangePassword(this.newPassword);
}