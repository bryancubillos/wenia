
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wenia/DAL/security/data/security_local_datasource.dart';

import 'package:wenia/DAL/security/data/security_remote_datasource.dart';
import 'package:wenia/core/Entities/common/result_entity.dart';
import 'package:wenia/core/Entities/security/user_entity.dart';

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
      UserEntity localUser = await SecurityLocalDatasource().getUser() ?? UserEntity();
      localUser.email = user.email;
      localUser.isLogged = 1;
      
      // If the user there arent in the local database, save it
      if(await SecurityLocalDatasource().usersRowCount() == 0) {
        await SecurityLocalDatasource().saveUser(localUser);
      }
      else {
        await SecurityLocalDatasource().updateUser(localUser);
      }
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
    UserEntity? user = await SecurityLocalDatasource().getUser();

    if(user != null) {
      // Update user logic false to not logged
      user.isLogged = 0;
      await SecurityLocalDatasource().updateUser(user);
    }
  }

  Future<bool> changePassword(String currentPassword, String newPassword) async {
    bool result = false;

    if(await SecurityRemoteDatasource().reauthenticateUser(currentPassword)) {
      result = await SecurityRemoteDatasource().changePassword(newPassword);
    }
    
    return result;
  }
  
  // [User]
  Future<UserEntity?> getCurrentUser() async {
    UserEntity? currentUser;
    
    UserEntity? localUser = await SecurityLocalDatasource().getUser();
    User? remoteUser = SecurityRemoteDatasource().currentUser;

    if(localUser != null && remoteUser != null) {
      currentUser = localUser;
    }

    return currentUser;
  }

  Future<ResultEntity> updateUser(UserEntity user) async {
    ResultEntity result = ResultEntity.empty();
    
    result.id = await SecurityLocalDatasource().updateUser(user);
    result.result = result.id > 0;

    return result;
  }

  // [Database]
  Future<bool> initDatabase() async {
    return await SecurityLocalDatasource().initDatabase();
  }
}