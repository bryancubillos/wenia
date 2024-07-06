part of 'crypto_list_bloc.dart';

sealed class CryptoListEvent {
  const CryptoListEvent();
}

final class GetCoins extends CryptoListEvent {
  final bool sortDescending;
  final String search;
  final bool isFavorite;
  
  const GetCoins(this.sortDescending, this.search, this.isFavorite);
}