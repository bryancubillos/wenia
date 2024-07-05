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
  Future<List<CoinEntity>> getCoins(bool sortDescending) async {
    ResultEntity result = await CryptoDAL().getCoins();

    if(result.result) {
      // Sort coins
      if(sortDescending) {
        List<CoinEntity> coinsDesc = result.data;

        coinsDesc.sort((a, b) => b.currentPrice.compareTo(a.currentPrice));

        return coinsDesc;
      } else {
        List<CoinEntity> coinsAsc = result.data;

        coinsAsc.sort((a, b) => a.currentPrice.compareTo(b.currentPrice));

        return coinsAsc;
      }
    }

    return [];
  }
}