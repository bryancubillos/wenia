class UserEntity {
  String? email;
  String? name;
  String? userId;
  DateTime? birthDate;
  int? isLogged;

  UserEntity();

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    UserEntity userEntity = UserEntity();

    userEntity.email = map['email'];
    userEntity.name = map['name'];
    userEntity.userId = map['userId'];
    userEntity.birthDate = map['birthDate'];
    userEntity.isLogged = map['isLogged'];
    
    return userEntity;
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'userId': userId,
      'birthDate': birthDate,
      'isLogged': isLogged
    };
  } 
}