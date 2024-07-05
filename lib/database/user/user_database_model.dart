import 'package:wenia/core/constants/database/database_constant.dart';

class UserDatabaseModel {
  
  static const databaseName = DatabaseConstant.userDatabaseName;
  static const databaseVersion = DatabaseConstant.userDatabaseVersion;

  static const table = 'userAccount';

  static const columnId = '_id';
  
  static const columnEmail = 'email';
  static const columnName = 'name';
  static const columnUserId = 'userId';
  static const columnBirthDate = 'birthDate';
  static const columnIsLogged = 'isLogged';
}