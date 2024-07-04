part of 'profile_bloc.dart';

sealed class ProfileEvent {
  const ProfileEvent();
}

final class DoGetProfileUser extends ProfileEvent {}

final class DoLogOutProfileUser extends ProfileEvent {}