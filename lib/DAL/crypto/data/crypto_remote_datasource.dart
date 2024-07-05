import 'dart:convert';

import 'package:wenia/DAL/base/http_remote_handler.dart';
import 'package:wenia/core/Entities/common/result_entity.dart';
import 'package:wenia/core/Entities/crypto/coin_entity.dart';

class CryptoRemoteDatasource {
  // [Properties]

  // [Server]
  final String _server = 'https://api.coingecko.com/api/v3';

  // [Endpoints]
  final String _endPoint = '/coins';

  // [Methods]
  final String _getCoins = '/markets?vs_currency=usd';

  // [Singleton]
  static final CryptoRemoteDatasource _instance = CryptoRemoteDatasource._constructor();

  factory CryptoRemoteDatasource() {
    return _instance;
  }

  // [Constructor]
  CryptoRemoteDatasource._constructor();

  // [Methods]
  Future<ResultEntity> getCoins() async {
    // Request POST
    ResultEntity result = await HttpRemoteHandler().baseGET(_server, '$_endPoint/$_getCoins');

    if(result.result) {
      List<dynamic> jsonMap = jsonDecode(result.data);
      List<CoinEntity> coins = CoinEntity.fromJsonList(jsonMap);

      result.data = coins;
    }

    return result;
  }

}