import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto_pulse/features/dashboard/data/coin_repository_impl.dart';
import 'package:crypto_pulse/features/dashboard/domain/coin_entity.dart';
import 'package:crypto_pulse/features/dashboard/domain/coin_repository.dart';

// Provider cho Dio
final dioProvider = Provider<Dio>((ref) => Dio());

// Provider cho Repository
final coinRepositoryProvider = Provider<CoinRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return CoinRepositoryImpl(dio);
});

// FutureProvider để lấy danh sách top coins
final topCoinsProvider = FutureProvider<List<Coin>>((ref) async {
  final repository = ref.watch(coinRepositoryProvider);
  return repository.getTopCoins(perPage: 10);
});

// Provider lưu từ khóa tìm kiếm
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider trả về danh sách coin đã được lọc
final filteredCoinsProvider = Provider<AsyncValue<List<Coin>>>((ref) {
  final coinsAsync = ref.watch(topCoinsProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  return coinsAsync.whenData((coins) {
    if (query.isEmpty) return coins;
    return coins.where((coin) {
      return coin.name.toLowerCase().contains(query) ||
             coin.symbol.toLowerCase().contains(query);
    }).toList();
  });
});
