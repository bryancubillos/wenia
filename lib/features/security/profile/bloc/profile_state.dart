part of 'profile_bloc.dart';

sealed class ProfileState {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final User? userLoaded;

  ProfileLoaded(this.userLoaded);
}