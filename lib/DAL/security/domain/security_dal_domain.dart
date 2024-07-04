
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wenia/DAL/security/data/security_local_datasource.dart';

import 'package:wenia/DAL/security/data/security_remote_datasource.dart';
import 'package:wenia/core/Entities/security/user_entity.dart';
import 'package:wenia/database/user/user_database.dart';

class SecurityDAL {
  // [Properties]

  // [Singleton]
  static final SecurityDAL _instance = SecurityDAL._constructor();

  factory SecurityDAL() {
    return _instance;
  }

  // [Constructor]
  SecurityDAL._constructor();

  // [Methods]

  // [Firebase]
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    User? user = await SecurityRemoteDatasource().signInWithEmailAndPassword(email, password);

    if(user != null) {
      UserEntity localUser = UserEntity();
      localUser.user = user;
      localUser.email = user.email;

      int saveResult = await SecurityLocalDatasource().saveUser(localUser);
    }

    return user;
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    return SecurityRemoteDatasource().createUserWithEmailAndPassword(email, password);
  }

  Future<void> signOut() async {
    // Remote
    await SecurityRemoteDatasource().signOut();

    // Local
    await SecurityLocalDatasource().signOut();
  }

  // [User]
  Future<User?> getCurrentUser() async {
    User? user = null;
    // = SecurityRemoteDatasource().currentUser;

    if(user == null) {
      UserEntity? localUser = await SecurityLocalDatasource().getUser();

      if(localUser != null) {
        user = localUser.user;
      }
    }

    return user;
  }

  // [Database]
  Future<void> initDatabase() async {
    await SecurityLocalDatasource().initDatabase();
  }
}