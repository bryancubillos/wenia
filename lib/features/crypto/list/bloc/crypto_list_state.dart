part of 'crypto_list_bloc.dart';

sealed class CryptoListState {
  const CryptoListState();
}

final class CryptoListInitial extends CryptoListState {}

final class CryptoListLoading extends CryptoListState {}

final class CryptoListLoaded extends CryptoListState {
  final List<CoinEntity> coins;
  final int countCompareCoins;

  const CryptoListLoaded(this.coins, this.countCompareCoins);
}