class UserEntity {
  String? email;
  String? name;
  String? userId;
  DateTime? birthDate;

  UserEntity();

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    UserEntity userEntity = UserEntity();

    userEntity.email = map['email'];
    userEntity.name = map['name'];
    userEntity.userId = map['userId'];
    userEntity.birthDate = map['birthDate'];
    
    return userEntity;
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'userId': userId,
      'birthDate': birthDate,
    };
  } 
}