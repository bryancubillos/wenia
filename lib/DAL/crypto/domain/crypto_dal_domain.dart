class CryptoDAL {
  // [Properties]

  // [Singleton]
  static final CryptoDAL _instance = CryptoDAL._constructor();

  factory CryptoDAL() {
    return _instance;
  }

  // [Constructor]
  CryptoDAL._constructor();

  // [Methods]
}