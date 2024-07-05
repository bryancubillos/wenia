import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SecurityRemoteDatasource {
  // [Properties]
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // [Singleton]
  static final SecurityRemoteDatasource _instance = SecurityRemoteDatasource._constructor();

  factory SecurityRemoteDatasource() {
    return _instance;
  }

  // [Constructor]
  SecurityRemoteDatasource._constructor();

  // [Methods]
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    User? user;

    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } catch (e) {
      if(kDebugMode) {
        print(e);
      }
    }

    return user;
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    User? user;

    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

    } catch (e) {
      if(kDebugMode) {
        print(e);
      }
    }

    return user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> changePassword(String newPassword) async {
    bool result = false;

    try {
      await _firebaseAuth.currentUser?.updatePassword(newPassword);
      result = true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return result;
  }

  Future<bool> reauthenticateUser(String password) async {
    bool result = false;

    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        AuthCredential temporaryCredential = EmailAuthProvider.credential(email: user.email ?? "", password: password);
        await user.reauthenticateWithCredential(temporaryCredential);
        result = true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Re-authentication failed: $e');
      }
    }

    return result;
  }
}