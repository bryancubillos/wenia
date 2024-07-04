part of 'security_bloc.dart';

sealed class SecurityEvent {
  const SecurityEvent();
}

final class DoGetSecurityUser extends SecurityEvent {}