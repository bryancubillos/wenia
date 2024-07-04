import 'package:firebase_auth/firebase_auth.dart';

class SecurityRemoteDatasource {
  // [Properties]
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // [end point]

  // [Singleton]
  static final SecurityRemoteDatasource _instance = SecurityRemoteDatasource._constructor();

  factory SecurityRemoteDatasource() {
    return _instance;
  }

  // [Constructor]
  SecurityRemoteDatasource._constructor();

  // [Methods]
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}