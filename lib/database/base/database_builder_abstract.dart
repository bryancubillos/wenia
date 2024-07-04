abstract class DatabaseBuilderAbstract {
  // [Methods]
  
  // [Constuctor]
  Future<void> initDatabase();

  // [Close]
  void reset();
  Future<void> dispose();
  Future<void> removeAllData();
  Future<void> deleteDatabase();
}