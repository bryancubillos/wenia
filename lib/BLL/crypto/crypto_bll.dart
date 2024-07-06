import 'package:wenia/DAL/crypto/domain/crypto_dal_domain.dart';
import 'package:wenia/core/Entities/common/result_entity.dart';
import 'package:wenia/core/Entities/crypto/coin_entity.dart';

class CryptoBll {
  // [Properties]

  // [Singleton]
  static final CryptoBll _instance = CryptoBll._constructor();

  factory CryptoBll() {
    return _instance;
  }

  // [Constructor]
  CryptoBll._constructor();

  // [Methods]
  Future<List<CoinEntity>> getCoins(bool sortDescending, String searchValue, bool onlyFavorites) async {
    ResultEntity result = await CryptoDAL().getCoins();
    List<CoinEntity> coins = [];

    if(result.result) {
      
      // Datasource
      coins = result.data;

      // Filter coins
      if(searchValue.isNotEmpty) {
        coins = coins.where((coin) => coin.name.toLowerCase().contains(searchValue.toLowerCase())).toList();
      }

      // Sort coins
      if(sortDescending) {
        coins.sort((a, b) => b.currentPrice.compareTo(a.currentPrice));
      } else {
        coins.sort((a, b) => a.currentPrice.compareTo(b.currentPrice));
      }

      // only favorites
      if(onlyFavorites) {
        coins = coins.where((coin) => coin.isFavorite).toList();
      }
    }

    return coins;
  }
}