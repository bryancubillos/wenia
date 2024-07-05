part of 'account_bloc.dart';

sealed class AccountEvent {
  const AccountEvent();
}

final class DoAccountLoad extends AccountEvent {}

final class DoAccountUpdate extends AccountEvent {
  final UserEntity user;

  const DoAccountUpdate(this.user);
}