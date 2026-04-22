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
  return repository.getTopCoins();
});
