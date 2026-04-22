import 'package:dio/dio.dart';
import '../domain/coin_entity.dart';
import '../domain/coin_repository.dart';
import 'coin_model.dart';

class CoinRepositoryImpl implements CoinRepository {
  final Dio _dio;

  CoinRepositoryImpl(this._dio);

  @override
  Future<List<Coin>> getTopCoins({int page = 1, int perPage = 20}) async {
    try {
      final response = await _dio.get(
        'https://api.coingecko.com/api/v3/coins/markets',
        queryParameters: {
          'vs_currency': 'usd',
          'order': 'market_cap_desc',
          'per_page': perPage,
          'page': page,
          'sparkline': true,
          'price_change_percentage': '24h',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CoinModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load coins');
      }
    } catch (e) {
      throw Exception('Error fetching coins: $e');
    }
  }

  @override
  Future<Coin> getCoinDetail(String id) async {
    // Để đơn giản, chúng ta có thể tái sử dụng getTopCoins hoặc gọi endpoint detail riêng
    // Hiện tại chúng ta tập trung vào danh sách Dashboard trước
    throw UnimplementedError();
  }
}
