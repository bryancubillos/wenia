part of 'card_bloc.dart';

sealed class CardState {
  const CardState();
}

final class CardInitial extends CardState {}

final class CardLoading extends CardState {}

final class CardLoaded extends CardState {
  const CardLoaded();
}
