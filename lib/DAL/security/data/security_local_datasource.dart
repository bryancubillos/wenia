import 'dart:async';

import 'package:wenia/core/Entities/security/user_entity.dart';
import 'package:wenia/database/user/user_database.dart';

class SecurityLocalDatasource {
  // [Singleton]
  static final SecurityLocalDatasource _instance = SecurityLocalDatasource._constructor();

  factory SecurityLocalDatasource() {
    return _instance;
  }

  // [Constructor]
  SecurityLocalDatasource._constructor();

  // [Methods]
  Future<int> saveUser(UserEntity user) async {
    return UserDatabase().saveUser(user);
  }

  Future<int> updateUser(UserEntity user) async {
    return UserDatabase().updateUser(user);
  }

  Future<UserEntity?> getUser() async {
    return UserDatabase().getUser();
  }

  Future<void> signOut() async {
    await UserDatabase().deleteUser();
  }

  // [Database]
  Future<bool> initDatabase() async {
    return await UserDatabase().initDatabase();
  }
}