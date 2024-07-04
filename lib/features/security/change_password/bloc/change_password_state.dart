part of 'change_password_bloc.dart';

sealed class ChangePasswordState {
  const ChangePasswordState();
}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordLoaded extends ChangePasswordState {
  final String message;
  
  ChangePasswordLoaded(this.message);
}

final class ChangePasswordSuccess extends ChangePasswordState {
  final bool? result;

  ChangePasswordSuccess(this.result);
}

final class ChangePasswordError extends ChangePasswordState {
  final String message;

  ChangePasswordError(this.message);
}