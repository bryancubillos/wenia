import 'package:wenia/DAL/crypto/data/crypto_remote_datasource.dart';
import 'package:wenia/core/Entities/common/result_entity.dart';

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
    return await CryptoRemoteDatasource().getCoins();
  }
  
}