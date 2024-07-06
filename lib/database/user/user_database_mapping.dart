import 'package:wenia/core/Entities/security/user_entity.dart';

class UserDatabaseMapping {
  
  Map<String, dynamic> convertUserToMap(UserEntity user) {
    Map<String, dynamic> userRow = <String, dynamic> 
    {
      "email": user.email,
      "name": user.name,
      "userId": user.userId,
      "birthDate": user.birthDate?.toString(),
      "isLogged": user.isLogged
    };

    return userRow;
  }

  UserEntity convertMapToUserEntity(Map<String, dynamic> user) {
    UserEntity userObject = UserEntity();

    userObject.email = user["email"];
    userObject.name = user["name"];
    userObject.userId = user["userId"];
    userObject.birthDate = user["birthDate"] == null ? null : DateTime.parse(user["birthDate"]);
    userObject.isLogged = user["isLogged"];

    return userObject;
  }

  List<UserEntity> convertMapListToUsers(List<Map<String, dynamic>> usersInDB) {
    List<UserEntity> users = [];

    for (var userInDB in usersInDB) {
      if(userInDB.isNotEmpty) {
        users.add(convertMapToUserEntity(userInDB));
      }
    }

    return users;
  }

  UserEntity convertMapListToUser(List<Map<String, dynamic>> usersInDB) {
    List<UserEntity> users = [];
    UserEntity user = UserEntity();

    for (var userInDB in usersInDB) {
      if(userInDB.isNotEmpty) {
        users.add(convertMapToUserEntity(userInDB));
      }
    }

    user = users.where((element) => element.isLogged == 1).isEmpty ? UserEntity() : users.where((element) => element.isLogged == 1).first;

    return user;
  }
}