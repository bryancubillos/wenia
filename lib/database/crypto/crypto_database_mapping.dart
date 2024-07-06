
import 'package:wenia/core/Entities/crypto/coin_entity.dart';

class CryptoDatabaseMapping {
  
  Map<String, dynamic> convertCryptoToMap(CoinEntity coin) {
    Map<String, dynamic> userRow = <String, dynamic> 
    {
      "cryptoId": coin.id,
      "isFavorite": coin.isFavorite,
    };

    return userRow;
  }

  CoinEntity convertMapToCryptoEntity(Map<String, dynamic> coin) {
    CoinEntity coinObject = CoinEntity.empty();

    coinObject.id = coin["cryptoId"];
    coinObject.isFavorite = coin["isFavorite"];

    return coinObject;
  }

  List<CoinEntity> convertMapListToCryptos(List<Map<String, dynamic>> coinsInDB) {
    List<CoinEntity> coins = [];

    for (var coinInDB in coinsInDB) {
      if(coinInDB.isNotEmpty) {
        coins.add(convertMapToCryptoEntity(coinInDB));
      }
    }

    return coins;
  }

  CoinEntity convertMapListToCrypto(List<Map<String, dynamic>> coinsInDB) {
    List<CoinEntity> coins = [];
    CoinEntity coin = CoinEntity.empty();

    for (var coinInDB in coinsInDB) {
      if(coinInDB.isNotEmpty) {
        coins.add(convertMapToCryptoEntity(coinInDB));
      }
    }

    if(coins.isNotEmpty) {
      coin = coins[0];
    }

    return coin;
  }
}