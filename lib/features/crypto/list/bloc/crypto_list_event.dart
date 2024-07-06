part of 'crypto_list_bloc.dart';

sealed class CryptoListEvent {
  const CryptoListEvent();
}

final class DoGetCoins extends CryptoListEvent {
  final bool sortDescending;
  final String search;
  final bool isFavorite;
  
  const DoGetCoins(this.sortDescending, this.search, this.isFavorite);
}


final class DoGetWhitoutInfoCoins extends CryptoListEvent {}