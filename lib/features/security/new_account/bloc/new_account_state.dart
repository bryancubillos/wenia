part of 'new_account_bloc.dart';

sealed class NewAccountState {
  const NewAccountState();
}

final class NewAccountInitial extends NewAccountState {}

// [States]
final class NewAccountLoading extends NewAccountState {}

final class NewAccountLoaded extends NewAccountState {
  NewAccountLoaded();
}

final class NewAccountSuccess extends NewAccountState {
  final User? userLogin;

  NewAccountSuccess(this.userLogin);
}

final class NewAccountError extends NewAccountState {
  final String message;

  NewAccountError(this.message);
}