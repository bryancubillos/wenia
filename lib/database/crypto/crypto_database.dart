import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:wenia/core/Entities/crypto/coin_entity.dart';
import 'package:wenia/core/constants/database/database_constant.dart';
import 'package:wenia/core/utils/io/directory_util.dart';
import 'package:wenia/database/base/database_builder_abstract.dart';
import 'package:wenia/database/crypto/crypto_database_mapping.dart';
import 'package:wenia/database/crypto/crypto_database_model.dart';

class CryptoDatabase extends DatabaseBuilderAbstract {

  // [Properties]
  late Database _dbCrypto;
  late bool isStoreOpened = false;

  // [Constructor]
  CryptoDatabase._constructor();
  
  // [Singleton]
  static CryptoDatabase _instance = CryptoDatabase._constructor();

  factory CryptoDatabase() {
    return _instance;
  }

  // [Methods] [Override]

  // [Constuctor]
  @override
  Future<bool> initDatabase() async {
    final documentsDirectory = await DirectoryUtil. getDirectory(DatabaseConstant.cryptoDatabaseName);
    final path = join(documentsDirectory.path, DatabaseConstant.cryptoDatabaseName);
    
    try {
      _dbCrypto = await openDatabase(
        path,
        version: DatabaseConstant.cryptoDatabaseVersion,
        onCreate: _onCreate,
      );
      
      isStoreOpened = true;
    }
    catch(e) {
      await deleteDatabase();
      
      isStoreOpened = false;
    }

    return isStoreOpened;
  }
  
  Future _onCreate(Database db, int version) async {
    await db.execute('''
            CREATE TABLE ${CryptoDatabaseModel.table} (
              ${CryptoDatabaseModel.columnId} INTEGER PRIMARY KEY,
              ${CryptoDatabaseModel.columnCryptoId} TEXT,
              ${CryptoDatabaseModel.columnIsFavorite} INTEGER
            )
            ''');
  }

  // [Close]
  @override
  void reset() {
    _instance = CryptoDatabase._constructor();
  }

  @override
  Future<void> dispose() async {
    isStoreOpened = false;
  }

  @override
  Future<void> removeAllData() async {
    if(isStoreOpened) {
      await _dbCrypto.delete(
        CryptoDatabaseModel.table
      );
    }
  }

  @override
  Future<void> deleteDatabase() async {
    if(isStoreOpened){
      await DirectoryUtil.deleteDirectory(DatabaseConstant.cryptoDatabaseName);
    }
  }

  // [Methods]

  // [Crypto]
  Future<CoinEntity?> getCoin(String cryptoId) async {
    if(isStoreOpened) {
      List<Map<String, dynamic>> coinsInDB = await _dbCrypto.query(CryptoDatabaseModel.table);
      List<CoinEntity> coins = CryptoDatabaseMapping().convertMapListToCryptos(coinsInDB);
      CoinEntity coin = CoinEntity.empty();

      coin = coins.firstWhere((element) => element.id == cryptoId, orElse: () => CoinEntity.empty());
      
      return coin;
    }
    else {
      return null;
    }
  }

  Future<int> saveCoin(CoinEntity coin) async {
    if(isStoreOpened){
      Map<String, dynamic> coinRow = CryptoDatabaseMapping().convertCryptoToMap(coin);
      return await _dbCrypto.insert(CryptoDatabaseModel.table, coinRow);
    }
    return 0;
  }

  Future<int> updateCoin(CoinEntity coin) async {
    if(isStoreOpened){
      Map<String, dynamic> mapToUpdate = CryptoDatabaseMapping().convertCryptoToMap(coin);
      String key = mapToUpdate[CryptoDatabaseModel.columnCryptoId];
      
      return await _dbCrypto.update(
        CryptoDatabaseModel.table,
        mapToUpdate,
        where: '${CryptoDatabaseModel.columnCryptoId} = ?',
        whereArgs: [key],
      );
    }
  
    return 0;   
  }

  Future<int> deleteCoins() async {
    if(isStoreOpened) {
      return await _dbCrypto.delete(
        CryptoDatabaseModel.table
      );
    }
    else {
      return 0;
    }
  }

  // [Crypto]
  Future<int> coinsRowCount() async {
    if(isStoreOpened){
      final results = await _dbCrypto.rawQuery('SELECT COUNT(*) FROM ${CryptoDatabaseModel.table}');
      return Sqflite.firstIntValue(results) ?? 0;
    }
    return 0;
  }

  Future<List<CoinEntity>> selectCoins() async {
    if(isStoreOpened) {
      List<CoinEntity> coins = [];

      List<Map<String, dynamic>> coinsInDB = await _dbCrypto.query(CryptoDatabaseModel.table);
      coins = CryptoDatabaseMapping().convertMapListToCryptos(coinsInDB);

      return coins;
    }
    else {
      return [];
    }
  }

}