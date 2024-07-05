part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent {
  const ChangePasswordEvent();
}

class DoChangePassword extends ChangePasswordEvent {
  final String currentPassword;
  final String newPassword;
  final String repeatPassword;

  const DoChangePassword(this.currentPassword, this.newPassword, this.repeatPassword);
}