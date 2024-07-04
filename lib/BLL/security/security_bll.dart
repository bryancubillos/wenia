import 'package:firebase_auth/firebase_auth.dart';

import 'package:wenia/DAL/security/domain/security_dal_domain.dart';
import 'package:wenia/core/Entities/common/result_entity.dart';
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
      try {
        user = await SecurityDAL().signInWithEmailAndPassword(email, password);
      } catch (e) {
        print(e);
      }
    }

    return user;
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    User? user;
    
    if(email.isNotEmpty || password.isNotEmpty){
      try {
        user = await SecurityDAL().createUserWithEmailAndPassword(email, password);
      } catch (e) {
        print(e);
      }
    }

    return user;
  }

  Future<void> signOut() async {
    return SecurityDAL().signOut();
  }

  Future<User?> getCurrentUser() async {
    return SecurityDAL().getCurrentUser();
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
    
    if(result.result && password.isEmpty) {
      result.result = false;
      result.cultureMessage = "login-registrer-empty-information-password";
    }
    
    if(result.result && email.length < EnvironmentConfig.minAccountNameLength) {
      result.result = false;
      result.cultureMessage = "login-registrer-email-min";
    }
    
    if(result.result && password.length < EnvironmentConfig.minPasswordLength) {
      result.result = false;
      result.cultureMessage = "login-registrer-password-min";
    }

    if(result.result && verifyAge == false) {
      result.result = false;
      result.cultureMessage = "login-registrer-age-error-message";
    }

    return result;
  }

}