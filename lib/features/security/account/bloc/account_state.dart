part of 'account_bloc.dart';

sealed class AccountState {
  const AccountState();
}

final class AccountInitial extends AccountState {}

final class AccountLoaded extends AccountState {
  final UserEntity? user;

  const AccountLoaded(this.user);
}

final class AccountLoading extends AccountState {}

final class AccountSuccess extends AccountState {
  final bool? result;
  final String? message;

  AccountSuccess(this.result, this.message);
}

final class AccountError extends AccountState {
  final String? message;

  AccountError(this.message);
}