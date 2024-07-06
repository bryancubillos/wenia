part of 'compare_bloc.dart';

sealed class CompareState {
  const CompareState();
}

final class CompareInitial extends CompareState {}

final class CompareLoading extends CompareState {}

final class CompareLoaded extends CompareState {
  final List<CoinEntity> coins;

  const CompareLoaded(this.coins);
}