import 'package:wenia/core/Entities/common/result_entity.dart';
import 'package:wenia/core/Entities/crypto/coin_entity.dart';
import 'package:wenia/core/config/environment_config.dart';
import 'package:wenia/database/crypto/crypto_database.dart';

class CryptoLocalDatasource {
  // [properties]
  List<CoinEntity> localCoins  = [];
  DateTime lastUpdated = DateTime.now();

  // [Singleton]
  static final CryptoLocalDatasource _instance = CryptoLocalDatasource._constructor();

  factory CryptoLocalDatasource() {
    return _instance;
  }

  // [Constructor]
  CryptoLocalDatasource._constructor();

  // [Methods]
  ResultEntity saveLocalCoins(List<CoinEntity> coins) {
    ResultEntity result = ResultEntity.empty();

    localCoins = coins;
    result.result = true;
    lastUpdated = DateTime.now();

    return result;
  }

  ResultEntity getLocalCoins() {
    ResultEntity result = ResultEntity.empty();
    
    if(localCoins.isNotEmpty && DateTime.now().difference(lastUpdated).inMinutes < EnvironmentConfig.keepCoinsByTimeInMinutesDuration) {
      result.result = true;
      result.data = localCoins;
    }

    return result;
  }

  // [Database]
  Future<bool> initDatabase() async {
    return await CryptoDatabase().initDatabase();
  }
}