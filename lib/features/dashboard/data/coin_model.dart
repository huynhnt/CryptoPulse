import '../domain/coin_entity.dart';

class CoinModel extends Coin {
  CoinModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.image,
    required super.currentPrice,
    required super.priceChangePercentage24h,
    required super.marketCapRank,
    super.high24h,
    super.low24h,
    super.totalSupply,
    super.totalVolume,
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
      marketCapRank: json['market_cap_rank'] as int,
      high24h: json['high_24h'] != null ? (json['high_24h'] as num).toDouble() : null,
      low24h: json['low_24h'] != null ? (json['low_24h'] as num).toDouble() : null,
      totalSupply: json['total_supply'] != null ? (json['total_supply'] as num).toDouble() : null,
      totalVolume: json['total_volume'] != null ? (json['total_volume'] as num).toDouble() : null,
      sparkline: json['sparkline_in_7d'] != null 
          ? (json['sparkline_in_7d']['price'] as List).map((e) => (e as num).toDouble()).toList()
          : null,
    );
  }
}
