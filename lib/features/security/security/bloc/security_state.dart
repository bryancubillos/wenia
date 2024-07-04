part of 'security_bloc.dart';

sealed class SecurityState {
  const SecurityState();
}

final class SecurityInitial extends SecurityState {}

final class SecurityLoaded extends SecurityState {
  final User? user;

  const SecurityLoaded(this.user);
}
