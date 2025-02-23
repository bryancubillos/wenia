class CoinEntity {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  bool isFavorite;
  bool? isCompare;

  CoinEntity({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    this.isFavorite = false,
    this.isCompare = false
  });

  CoinEntity.empty()
    : id = "", 
      symbol = "",
      name = "",
      image = "",
      currentPrice = 0.0,
      isFavorite = false,
      isCompare = false;

  static List<CoinEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CoinEntity.empty().fromJson(json)).toList();
  }
  
  CoinEntity fromJson(item) {
    try {
      return CoinEntity(
        id: item['id'],
        symbol: item['symbol'],
        name: item['name'],
        image: item['image'],
        currentPrice: item['current_price'] is int
          ? item['current_price'].toDouble()
          : item['current_price']
      );
    } catch (e) {
      return CoinEntity.empty();
    }
  }
}