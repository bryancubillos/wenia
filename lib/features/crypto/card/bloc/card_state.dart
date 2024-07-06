part of 'card_bloc.dart';

sealed class CardState {
  const CardState();
}

final class CardInitial extends CardState {}

final class CardLoading extends CardState {}

final class CardLoaded extends CardState {}

final class CardShowMessage extends CardState {
  final String message;

  const CardShowMessage(this.message);
}
