import 'package:firebase_auth/firebase_auth.dart';

import 'package:wenia/DAL/security/domain/security_dal_domain.dart';
import 'package:wenia/core/Entities/common/result_entity.dart';
import 'package:wenia/core/Entities/security/user_entity.dart';
import 'package:wenia/core/config/environment_config.dart';

class SecurityBll {
  // [Properties]

  // [Singleton]
  static final SecurityBll _instance = SecurityBll._constructor();

  factory SecurityBll() {
    return _instance;
  }

  // [Constructor]
  SecurityBll._constructor();

  // [Methods]
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    User? user;
    
    if(email.isNotEmpty || password.isNotEmpty){
      user = await SecurityDAL().signInWithEmailAndPassword(email, password);
    }

    return user;
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    User? user;
    
    if(email.isNotEmpty || password.isNotEmpty){
      user = await SecurityDAL().createUserWithEmailAndPassword(email, password);
    }

    return user;
  }

  Future<void> signOut() async {
    return SecurityDAL().signOut();
  }

  Future<UserEntity?> getCurrentUser() async {
    return SecurityDAL().getCurrentUser();
  }

  Future<ResultEntity> changePassword(String newPassword) async {
    ResultEntity result = ResultEntity.empty();
    result.result = false;

    ResultEntity resultValidation = await itsPossibleChangePassword(newPassword);
    
    if(resultValidation.result) {
      result.result = await SecurityDAL().changePassword(newPassword);
    }
    else {
      result.cultureMessage = resultValidation.cultureMessage;
    }

    return result;
  }

  Future<ResultEntity> saveUser(UserEntity user) async {
    ResultEntity result = ResultEntity.empty();
    result.result = false;

    UserEntity? localUser = await SecurityBll().getCurrentUser();
    
    // Keep all information
    if(localUser != null) {
      user.email = localUser.email;
    }

    // Save user
    result = await SecurityDAL().updateUser(user);

    return result;
  }

  // [Functions]
  Future<ResultEntity> itsPossibleSaveAccount(String email, String password, bool verifyAge) async {
    ResultEntity result = ResultEntity.empty();
    
    // By default all is ok
    result.result = true;

    if(email.isEmpty) {
      result.result = false;
      result.cultureMessage = "login-registrer-empty-information-email";
    }
        
    if(result.result && email.length < EnvironmentConfig.minAccountNameLength) {
      result.result = false;
      result.cultureMessage = "login-registrer-email-min";
    }
    
    if(result.result && verifyAge == false) {
      result.result = false;
      result.cultureMessage = "login-registrer-age-error-message";
    }

    if(result.result) {
      result = await itsPossibleChangePassword(password);
    }

    return result;
  }

  Future<ResultEntity> itsPossibleChangePassword(String newPassword) async {
    ResultEntity result = ResultEntity.empty();
    
    // By default all is ok
    result.result = true;

    if(newPassword.isEmpty) {
      result.result = false;
      result.cultureMessage = "login-registrer-empty-information-password";
    }
    
    if(result.result && newPassword.length < EnvironmentConfig.minPasswordLength) {
      result.result = false;
      result.cultureMessage = "login-registrer-password-min";
    }

    return result;
  }

}