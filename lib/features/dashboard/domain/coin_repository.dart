import 'coin_entity.dart';

abstract class CoinRepository {
  Future<List<Coin>> getTopCoins({int page = 1, int perPage = 20});
  Future<Coin> getCoinDetail(String id);
}
