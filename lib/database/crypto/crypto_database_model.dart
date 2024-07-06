import 'package:wenia/core/constants/database/database_constant.dart';

class CryptoDatabaseModel {
  
  static const databaseName = DatabaseConstant.cryptoDatabaseName;
  static const databaseVersion = DatabaseConstant.cryptoDatabaseVersion;

  static const table = 'crypto';

  static const columnId = '_id';
  
  static const columnCryptoId = 'cryptoId';
  static const columnIsFavorite = 'isFavorite';
}