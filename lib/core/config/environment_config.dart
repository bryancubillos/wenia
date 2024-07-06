class EnvironmentConfig {
  // Wenia App title
  static const String weniaAppTitle = 'Wenia';
  static const String weniaVersion = 'v 1.0.0';
  // Security
  static const int maxAccountNameLength = 35;
  static const int maxPasswordLength = 15;
  static const int minAccountNameLength = 6;
  static const int minPasswordLength = 6;
  // Cripto
  static const int keepCoinsByTimeInMinutesDuration = 10; // => 10 minutes by avoid to call the API again (i dont have licence to use the API)
  static const int minSearchLength = 3;
  static const int maxCompareCoins = 2;
}