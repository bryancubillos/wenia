part of 'crypto_list_bloc.dart';

sealed class CryptoListEvent {
  const CryptoListEvent();
}

final class GetCoins extends CryptoListEvent {
  final bool sortDescending;
  
  const GetCoins(this.sortDescending);
}