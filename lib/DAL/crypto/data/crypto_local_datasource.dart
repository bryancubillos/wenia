import 'package:wenia/core/Entities/common/result_entity.dart';
import 'package:wenia/core/Entities/crypto/coin_entity.dart';
import 'package:wenia/core/config/environment_config.dart';
import 'package:wenia/database/crypto/crypto_database.dart';

class CryptoLocalDatasource {
  // [properties]
  List<CoinEntity> localCoins  = [];
  DateTime lastUpdated = DateTime.now();
  List<CoinEntity> compareCoins  = [];

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

  Future<ResultEntity> getLocalCoins() async {
    ResultEntity result = ResultEntity.empty();
    
    if(localCoins.isNotEmpty && DateTime.now().difference(lastUpdated).inMinutes < EnvironmentConfig.keepCoinsByTimeInMinutesDuration) {
      result.result = true;
      result.data = localCoins;
    }

    return result;
  }

  Future<List<CoinEntity>> getLocalDatabaseCoins() async {
    return  await CryptoDatabase().selectCoins();
  }

  Future<void> setFavorite(CoinEntity coin) async {
    CoinEntity cryptoDb = await CryptoDatabase().getCoin(coin.id) ?? CoinEntity.empty();
    
    if(cryptoDb.id.isNotEmpty) {
      await CryptoDatabase().updateCoin(coin);
    }
    else {
      await CryptoDatabase().saveCoin(coin);
    }
  }

  // [Database]
  Future<bool> initDatabase() async {
    return await CryptoDatabase().initDatabase();
  }

  // [Memory]
  Future<bool> setCompare(CoinEntity coin) async {
    bool result = false;

    if(coin.isCompare == true) {
      List<CoinEntity> coinsToCompare = await getCompareCoins();

      if(coinsToCompare.length < EnvironmentConfig.maxCompareCoins) {
        compareCoins.add(coin);
        result = true;
      }
    }
    else {
      compareCoins.removeWhere((element) => element.id == coin.id);
    }

    return result;
  }

  Future<List<CoinEntity>> getCompareCoins() async {
    return compareCoins;
  }
}