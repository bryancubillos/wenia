import 'package:wenia/DAL/crypto/data/crypto_local_datasource.dart';
import 'package:wenia/DAL/crypto/data/crypto_remote_datasource.dart';
import 'package:wenia/core/Entities/common/result_entity.dart';
import 'package:wenia/core/Entities/crypto/coin_entity.dart';

class CryptoDAL {
  // [Properties]

  // [Singleton]
  static final CryptoDAL _instance = CryptoDAL._constructor();

  factory CryptoDAL() {
    return _instance;
  }

  // [Constructor]
  CryptoDAL._constructor();

  // [Methods]
  Future<ResultEntity> getCoins() async {
    ResultEntity resultLocal = CryptoLocalDatasource().getLocalCoins();
    
    if(resultLocal.result) {
      // First local
      return resultLocal;
    }
    else {
      // Then remote
      ResultEntity remoteResult = await CryptoRemoteDatasource().getCoins();

      if(remoteResult.result) {
        CryptoLocalDatasource().saveLocalCoins(remoteResult.data);
      }

      return remoteResult;
    }
  }

  ResultEntity saveCoins(List<CoinEntity> coins) {
    return CryptoLocalDatasource().saveLocalCoins(coins);
  }
  
}