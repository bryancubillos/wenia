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
  Future<List<CoinEntity>> getCoins() async {
    ResultEntity result = await CryptoDAL().getCoins();
    List<CoinEntity> coins = [];

    if(result.result) {
      coins = result.data;
    }

    return coins;
  }
}