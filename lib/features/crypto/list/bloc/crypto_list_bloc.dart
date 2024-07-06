import 'package:bloc/bloc.dart';
import 'package:wenia/BLL/crypto/crypto_bll.dart';
import 'package:wenia/core/Entities/crypto/coin_entity.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  // [Properties]
  bool _sortDescending = true;
  bool _isFavorite = false;
  String _searchValue = "";

  // [Constructor]
  CryptoListBloc() : super(CryptoListInitial()) {
    on<DoGetCoins>(_onDoGetCoins);
    on<DoGetWhitoutInfoCoins>(_onDoGetWhitoutInfoCoins);
  }

  // [Methods]
  Future<void> _onDoGetCoins(DoGetCoins event, Emitter<CryptoListState> emit) async {
    emit(CryptoListLoading());

    _sortDescending = event.sortDescending;
    _searchValue = event.search;
    _isFavorite = event.isFavorite;

    await getCoins(emit);
  }

  Future<void> _onDoGetWhitoutInfoCoins(DoGetWhitoutInfoCoins event, Emitter<CryptoListState> emit) async {
    emit(CryptoListLoading());
    
    await getCoins(emit);
  }

  // [Methods]
  Future<void> getCoins(Emitter<CryptoListState> emit) async {
    // Get coins
    List<CoinEntity> coins = [];
    coins = await CryptoBll().getCoins(_sortDescending, _searchValue, _isFavorite);

    // How many coins are being compared
    int countCompareCoins = await CryptoBll().getCompareCoinsCount();
    
    emit(CryptoListLoaded(coins, countCompareCoins));
  }
}
