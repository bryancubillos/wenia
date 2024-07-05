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

  Future<ResultEntity> changePassword(String currentPassword, String newPassword, String repeatPassword) async {
    ResultEntity result = ResultEntity.empty();
    result.result = false;

    ResultEntity resultValidation = ResultEntity.empty();
    // By default all is ok
    resultValidation.result = true;
    
    // Current password validation
    resultValidation = await itsPossibleChangePassword(currentPassword, "login-registrer-empty-information-password", "login-registrer-password-min");

    // New password validation
    resultValidation = await itsPossibleChangePassword(newPassword, "login-registrer-empty-information-password-new", "login-registrer-password-min-new");

    // Repeat password validation
    resultValidation = await itsPossibleChangePassword(repeatPassword, "login-registrer-empty-information-password-repeat", "login-registrer-password-min-repeat");

    // Check if the new password and the repeat password are the same
    if(resultValidation.result && newPassword != repeatPassword) {
      resultValidation.result = false;
      resultValidation.cultureMessage = "login-registrer-password-not-equal";
    }

    // Check new password diferent to current password
    if(resultValidation.result && currentPassword == newPassword) {
      resultValidation.result = false;
      resultValidation.cultureMessage = "login-registrer-password-are-equal";
    }
        
    if(resultValidation.result) {
      result.result = await SecurityDAL().changePassword(currentPassword, newPassword);

      if(result.result == false) {
        result.cultureMessage = "change-password-error-message";
      }
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
      result = await itsPossibleChangePassword(password, "login-registrer-empty-information-password", "login-registrer-password-min");
    }

    return result;
  }

  Future<ResultEntity> itsPossibleChangePassword(String passwordValue, String emptyError, String minLength) async {
    ResultEntity result = ResultEntity.empty();
    
    // By default all is ok
    result.result = true;

    if(passwordValue.isEmpty) {
      result.result = false;
      result.cultureMessage = emptyError;
    }
    
    if(result.result && passwordValue.length < EnvironmentConfig.minPasswordLength) {
      result.result = false;
      result.cultureMessage = minLength;
    }

    return result;
  }

}