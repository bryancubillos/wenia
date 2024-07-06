import 'package:bloc/bloc.dart';

import 'package:wenia/BLL/crypto/crypto_bll.dart';
import 'package:wenia/core/Entities/crypto/coin_entity.dart';

part 'compare_event.dart';
part 'compare_state.dart';

class CompareBloc extends Bloc<CompareEvent, CompareState> {
  CompareBloc() : super(CompareInitial()) {
    on<DoGetCompareCoins>(_onDoGetCompareCoins);
  }

  // [Methods]
  Future<void> _onDoGetCompareCoins(DoGetCompareCoins event, Emitter<CompareState> emit) async {
    emit(CompareLoading());

    // Get coins
    List<CoinEntity> coins = [];
    coins = await CryptoBll().getCompareCoins();

    emit(CompareLoaded(coins));
  }
}
