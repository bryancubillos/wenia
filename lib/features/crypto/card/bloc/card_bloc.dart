import 'package:bloc/bloc.dart';

import 'package:wenia/BLL/crypto/crypto_bll.dart';
import 'package:wenia/core/Entities/crypto/coin_entity.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardInitial()) {
    on<DoSetFavorite>(_onDoSetFavorite);
  }

  // [Methods]
  Future<void> _onDoSetFavorite(DoSetFavorite event, Emitter<CardState> emit) async {
    emit(CardLoading());

    // Save favorite status by Crypto card
    await CryptoBll().setFavorite(event.coin);

    emit(const CardLoaded());
  }
}
