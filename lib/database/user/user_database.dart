import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:wenia/core/Entities/security/user_entity.dart';
import 'package:wenia/core/constants/database/database_constant.dart';
import 'package:wenia/core/utils/io/directory_util.dart';
import 'package:wenia/database/base/database_builder_abstract.dart';
import 'package:wenia/database/user/user_database_mapping.dart';
import 'package:wenia/database/user/user_database_model.dart';

class UserDatabase extends DatabaseBuilderAbstract {

  // [Properties]
  late Database _dbUser;
  late bool isStoreOpened = false;

  // [Constructor]
  UserDatabase._constructor();
  
  // [Singleton]
  static UserDatabase _instance = UserDatabase._constructor();

  factory UserDatabase() {
    return _instance;
  }

  // [Methods] [Override]

  // [Constuctor]
  @override
  Future<bool> initDatabase() async {
    final documentsDirectory = await DirectoryUtil. getDirectory(DatabaseConstant.userDatabaseName);
    final path = join(documentsDirectory.path, DatabaseConstant.userDatabaseName);
    
    try {
      _dbUser = await openDatabase(
        path,
        version: DatabaseConstant.userDatabaseVersion,
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
            CREATE TABLE ${UserDatabaseModel.table} (
              ${UserDatabaseModel.columnId} INTEGER PRIMARY KEY,
              ${UserDatabaseModel.columnEmail} TEXT,
              ${UserDatabaseModel.columnName} TEXT,
              ${UserDatabaseModel.columnUserId} TEXT,
              ${UserDatabaseModel.columnBirthDate} TEXT,
              ${UserDatabaseModel.columnIsLogged} INTEGER
            )
            ''');
  }

  // [Close]
  @override
  void reset() {
    _instance = UserDatabase._constructor();
  }

  @override
  Future<void> dispose() async {
    isStoreOpened = false;
  }

  @override
  Future<void> removeAllData() async {
    if(isStoreOpened) {
      await _dbUser.delete(
        UserDatabaseModel.table
      );
    }
  }

  @override
  Future<void> deleteDatabase() async {
    if(isStoreOpened){
      await DirectoryUtil.deleteDirectory(DatabaseConstant.userDatabaseName);
    }
  }

  // [User]
  Future<UserEntity?> getUser() async {
    if(isStoreOpened) {
      UserEntity localUser;

      List<Map<String, dynamic>> usersInDB = await _dbUser.query(UserDatabaseModel.table);
      localUser = UserDatabaseMapping().convertMapListToUser(usersInDB);

      return localUser;
    }
    else {
      return null;
    }
  }

  Future<int> saveUser(UserEntity user) async {
    if(isStoreOpened){
      Map<String, dynamic> userRow = UserDatabaseMapping().convertUserToMap(user);
      return await _dbUser.insert(UserDatabaseModel.table, userRow);
    }
    return 0;
  }

  Future<int> updateUser(UserEntity user) async {
    if(isStoreOpened){
      Map<String, dynamic> mapToUpdate = UserDatabaseMapping().convertUserToMap(user);
      String key = mapToUpdate[UserDatabaseModel.columnEmail];
      
      return await _dbUser.update(
        UserDatabaseModel.table,
        mapToUpdate,
        where: '${UserDatabaseModel.columnEmail} = ?',
        whereArgs: [key],
      );
    }
  
    return 0;   
  }

  Future<UserEntity> getUserByemail(String email) async {
    if(isStoreOpened){
      List<Map<String, dynamic>> usersInDB = await _dbUser.query(UserDatabaseModel.table);
      List<UserEntity> localUsers = UserDatabaseMapping().convertMapListToUsers(usersInDB);
      
      return localUsers.where((element) => element.email == email).isEmpty ? UserEntity() : localUsers.where((element) => element.email == email).first;
    }
  
    return UserEntity();   
  }

  Future<int> deleteUser() async {
    if(isStoreOpened) {
      return await _dbUser.delete(
        UserDatabaseModel.table
      );
    }
    else {
      return 0;
    }
  }

  // [Users]
  Future<int> usersRowCount() async {
    if(isStoreOpened){
      final results = await _dbUser.rawQuery('SELECT COUNT(*) FROM ${UserDatabaseModel.table}');
      return Sqflite.firstIntValue(results) ?? 0;
    }
    return 0;
  }

  Future<List<UserEntity>> selectUsers() async {
    if(isStoreOpened) {
      List<UserEntity> users = [];

      List<Map<String, dynamic>> usersInDB = await _dbUser.query(UserDatabaseModel.table);
      users = UserDatabaseMapping().convertMapListToUsers(usersInDB);

      return users;
    }
    else {
      return [];
    }
  }

}