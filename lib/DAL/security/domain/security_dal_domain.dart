
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wenia/DAL/security/data/security_remote_datasource.dart';

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
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    return SecurityRemoteDatasource().signInWithEmailAndPassword(email, password);
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    return SecurityRemoteDatasource().createUserWithEmailAndPassword(email, password);
  }

  Future<void> signOut() async {
    return SecurityRemoteDatasource().signOut();
  }

  Future<User?> getCurrentUser() async {
    return SecurityRemoteDatasource().currentUser;
  }
}