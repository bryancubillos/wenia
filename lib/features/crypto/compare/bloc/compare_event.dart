part of 'compare_bloc.dart';

sealed class CompareEvent {
  const CompareEvent();
}

final class DoGetCompareCoins extends CompareEvent {}