class Coin {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double priceChangePercentage24h;
  final int marketCapRank;
  final double? high24h;
  final double? low24h;
  final double? totalSupply;
  final double? totalVolume;
  final List<double>? sparkline;

  Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    required this.marketCapRank,
    this.high24h,
    this.low24h,
    this.totalSupply,
    this.totalVolume,
    this.sparkline,
  });
}
