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
    ResultEntity result = ResultEntity.empty();
    ResultEntity resultLocal = await CryptoLocalDatasource().getLocalCoins();
    
    if(resultLocal.result) {
      // First local
      result = resultLocal;
    }
    else {
      // Then remote
      ResultEntity remoteResult = await CryptoRemoteDatasource().getCoins();

      if(remoteResult.result) {
        CryptoLocalDatasource().saveLocalCoins(remoteResult.data);
      }

      result = remoteResult;
    }

    // Join whit local database
    List<CoinEntity> databaseCryptos = await CryptoLocalDatasource().getLocalDatabaseCoins();
    List<CoinEntity> databaseCoins = [];

    if(databaseCryptos.isNotEmpty) {
      databaseCoins = result.data;
      
      // Join
      for (CoinEntity coinDB in databaseCryptos) {        
        for (CoinEntity coinLocal in databaseCoins) {
          if(coinLocal.id == coinDB.id) {
            coinLocal.isFavorite = coinDB.isFavorite;
          }
        }
      }

      result.data = databaseCoins;
    }  

    return result;
  }

  ResultEntity saveCoins(List<CoinEntity> coins) {
    return CryptoLocalDatasource().saveLocalCoins(coins);
  }
  
  Future<void> setFavorite(CoinEntity coin) async {
    await CryptoLocalDatasource().setFavorite(coin);
  }

  // [Memory]
  Future<bool> setCompare(CoinEntity coin) async {
    return await CryptoLocalDatasource().setCompare(coin);
  }

  Future<List<CoinEntity>> getCompareCoins() async {
    return await CryptoLocalDatasource().getCompareCoins();
  }

  // [Database]
  Future<bool> initDatabase() async {
    return await CryptoLocalDatasource().initDatabase();
  }
}