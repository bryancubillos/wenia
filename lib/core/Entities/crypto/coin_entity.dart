class CoinEntity {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;

  CoinEntity({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
  });

  CoinEntity.empty()
    : id = "", 
      symbol = "",
      name = "",
      image = "",
      currentPrice = 0.0;
}