import '../domain/coin_entity.dart';

class CoinModel extends Coin {
  CoinModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.image,
    required super.currentPrice,
    required super.priceChangePercentage24h,
    super.sparkline,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: (json['current_price'] as num).toDouble(),
      priceChangePercentage24h: (json['price_change_percentage_24h'] as num).toDouble(),
      sparkline: json['sparkline_in_7d'] != null 
          ? (json['sparkline_in_7d']['price'] as List).map((e) => (e as num).toDouble()).toList()
          : null,
    );
  }
}
