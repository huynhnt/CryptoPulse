import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto_pulse/features/dashboard/domain/coin_entity.dart';
import 'package:crypto_pulse/features/dashboard/presentation/providers/coin_provider.dart';

class AllCoinsState {
  final List<Coin> coins;
  final int page;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final bool isInitialLoading;
  final String? error;

  AllCoinsState({
    this.coins = const [],
    this.page = 1,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.isInitialLoading = false,
    this.error,
  });

  AllCoinsState copyWith({
    List<Coin>? coins,
    int? page,
    bool? isLoadingMore,
    bool? hasReachedMax,
    bool? isInitialLoading,
    String? error,
  }) {
    return AllCoinsState(
      coins: coins ?? this.coins,
      page: page ?? this.page,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      error: error ?? this.error,
    );
  }
}

class AllCoinsNotifier extends StateNotifier<AllCoinsState> {
  final Ref ref;

  AllCoinsNotifier(this.ref) : super(AllCoinsState()) {
    fetchInitialCoins();
  }

  Future<void> fetchInitialCoins() async {
    state = state.copyWith(isInitialLoading: true, error: null);
    try {
      final repository = ref.read(coinRepositoryProvider);
      final newCoins = await repository.getTopCoins(page: 1, perPage: 50);
      
      state = state.copyWith(
        coins: newCoins,
        page: 1,
        isInitialLoading: false,
        hasReachedMax: newCoins.length < 50,
      );
    } catch (e) {
      state = state.copyWith(
        isInitialLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> fetchNextPage() async {
    if (state.isLoadingMore || state.hasReachedMax || state.isInitialLoading) return;

    state = state.copyWith(isLoadingMore: true, error: null);
    
    try {
      final nextPage = state.page + 1;
      final repository = ref.read(coinRepositoryProvider);
      final newCoins = await repository.getTopCoins(page: nextPage, perPage: 50);
      
      // Filter out duplicates just in case
      final currentIds = state.coins.map((c) => c.id).toSet();
      final filteredNewCoins = newCoins.where((c) => !currentIds.contains(c.id)).toList();

      state = state.copyWith(
        coins: [...state.coins, ...filteredNewCoins],
        page: nextPage,
        isLoadingMore: false,
        hasReachedMax: newCoins.length < 50,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }
}

final allCoinsNotifierProvider = StateNotifierProvider<AllCoinsNotifier, AllCoinsState>((ref) {
  return AllCoinsNotifier(ref);
});
