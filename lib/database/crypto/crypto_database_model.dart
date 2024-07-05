import 'package:wenia/core/constants/database/database_constant.dart';

class UserDatabaseModel {
  
  static const databaseName = DatabaseConstant.cryptoDatabaseName;
  static const databaseVersion = DatabaseConstant.cryptoDatabaseVersion;

  static const table = 'crypto';

  static const columnId = '_id';
  
  static const columnCryptoId = 'cryptoId';
  static const columnName = 'name';
  static const columnSymbol = 'symbol';
  static const columnCurrentPrice = 'currentPrice';
  static const columnImage = 'image';
}