import 'package:bloc/bloc.dart';
import 'package:wenia/BLL/crypto/crypto_bll.dart';
import 'package:wenia/core/Entities/crypto/coin_entity.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  // [Properties]
  bool _sortDescending = true;

  // [Constructor]
  CryptoListBloc() : super(CryptoListInitial()) {
    on<GetCoins>(_onGetCoins);
  }

  // [Methods]
  Future<void> _onGetCoins(GetCoins event, Emitter<CryptoListState> emit) async {
    emit(CryptoListLoading());

    _sortDescending = event.sortDescending;

    // Get coins
    List<CoinEntity> coins = await CryptoBll().getCoins(_sortDescending);

    emit(CryptoListLoaded(coins));
  }
}
