import 'package:flutter/foundation.dart';
import 'package:wenia/database/base/database_builder_abstract.dart';

class DatabaseDirector {

  static const String _messageErrorConstructDatabase = "Impossible create database ";

  // [Methods]
  Future<void> constructStore(DatabaseBuilderAbstract database) async {
    try {
      await database.initDatabase();
    }
    catch (error) {
      if(kDebugMode) {
        print("$_messageErrorConstructDatabase: $error $database");
      }

      database.reset();
      await database.deleteDatabase();
    }
  }
}