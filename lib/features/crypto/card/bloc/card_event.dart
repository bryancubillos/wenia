part of 'card_bloc.dart';

sealed class CardEvent {
  const CardEvent();
}

final class DoSetFavorite extends CardEvent {
  final CoinEntity coin;
  
  const DoSetFavorite(this.coin);
}

final class DoSetCompare extends CardEvent {
  final CoinEntity coin;
  
  const DoSetCompare(this.coin);
}