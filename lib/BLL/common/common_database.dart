import 'package:wenia/DAL/crypto/domain/crypto_dal_domain.dart';
import 'package:wenia/DAL/security/domain/security_dal_domain.dart';

class CommonDatabase {
  // [Singleton]
  static final CommonDatabase _instance = CommonDatabase._constructor();

  // [Constructor]
  CommonDatabase._constructor();

  // [Instance]
  factory CommonDatabase() {
    return _instance;
  }

  // [Database]
  Future<bool> initDatabase() async {
    await SecurityDAL().initDatabase();

    return await CryptoDAL().initDatabase();
  }
}