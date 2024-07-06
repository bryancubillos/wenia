import 'package:bloc/bloc.dart';

import 'package:wenia/BLL/crypto/crypto_bll.dart';
import 'package:wenia/core/Entities/common/result_entity.dart';
import 'package:wenia/core/Entities/crypto/coin_entity.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardInitial()) {
    on<DoSetFavorite>(_onDoSetFavorite);
    on<DoSetCompare>(_onDoSetCompare);
  }

  // [Methods]
  Future<void> _onDoSetFavorite(DoSetFavorite event, Emitter<CardState> emit) async {
    emit(CardLoading());

    // Save favorite status by Crypto card
    await CryptoBll().setFavorite(event.coin);
    
    // How many coins are being compared
    int countCompareCoins = await CryptoBll().getCompareCoinsCount();

    emit(CardLoaded(countCompareCoins));
  }

  Future<void> _onDoSetCompare(DoSetCompare event, Emitter<CardState> emit) async {
    emit(CardLoading());

    // Save compare status by Crypto card
    ResultEntity result = await CryptoBll().setCompare(event.coin);
    
    // How many coins are being compared
    int countCompareCoins = await CryptoBll().getCompareCoinsCount();

    emit(CardShowMessage(result.cultureMessage));

    emit(CardLoaded(countCompareCoins));
  }
}
