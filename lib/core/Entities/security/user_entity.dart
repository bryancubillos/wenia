import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  String? email;
  String? password;
  String? name;
  String? id;
  DateTime? birthDate;
  User? user;

  UserEntity();

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    UserEntity userEntity = UserEntity();

    userEntity.email = map['email'];
    userEntity.password = map['password'];
    userEntity.name = map['name'];
    userEntity.id = map['id'];
    userEntity.birthDate = map['birthDate'];
    userEntity.user = map['user'];
    
    return userEntity;
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'id': id,
      'birthDate': birthDate,
      'user': user,
    };
  } 
}