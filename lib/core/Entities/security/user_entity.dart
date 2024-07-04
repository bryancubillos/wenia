class UserEntity {
  String? email;
  String? name;
  String? id;
  DateTime? birthDate;

  UserEntity();

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    UserEntity userEntity = UserEntity();

    userEntity.email = map['email'];
    userEntity.name = map['name'];
    userEntity.id = map['id'];
    userEntity.birthDate = map['birthDate'];
    
    return userEntity;
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'id': id,
      'birthDate': birthDate,
    };
  } 
}