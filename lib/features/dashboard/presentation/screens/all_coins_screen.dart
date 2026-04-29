import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto_pulse/core/constants/app_colors.dart';
import 'package:crypto_pulse/features/dashboard/presentation/providers/all_coins_provider.dart';
import 'package:crypto_pulse/features/dashboard/presentation/widgets/coin_list_item.dart';
import 'package:crypto_pulse/core/util/animations.dart';
import 'package:crypto_pulse/features/dashboard/presentation/screens/main_screen.dart';

class AllCoinsScreen extends ConsumerStatefulWidget {
  const AllCoinsScreen({super.key});

  @override
  ConsumerState<AllCoinsScreen> createState() => _AllCoinsScreenState();
}

class _AllCoinsScreenState extends ConsumerState<AllCoinsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(allCoinsNotifierProvider.notifier).fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(allCoinsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Coins'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: state.isInitialLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : state.error != null && state.coins.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: AppColors.secondary, size: 48),
                      const SizedBox(height: 16),
                      Text('Error: ${state.error}', textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.read(allCoinsNotifierProvider.notifier).fetchInitialCoins(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => ref.read(allCoinsNotifierProvider.notifier).fetchInitialCoins(),
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16.0),
                    itemCount: state.coins.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < state.coins.length) {
                        return FadeInSlide(
                          delay: Duration(milliseconds: (index % 10) * 50),
                          duration: const Duration(milliseconds: 500),
                          child: CoinListItem(coin: state.coins[index]),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Center(
                            child: CircularProgressIndicator(color: AppColors.primary),
                          ),
                        );
                      }
                    },
                  ),
                ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.divider.withOpacity(0.5), width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            if (index == 0) {
              Navigator.pop(context);
            } else if (index == 1) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(initialIndex: 1),
                ),
                (route) => false,
              );
            }
          },
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: 'Market',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_rounded),
              label: 'Wallet',
            ),
          ],
        ),
      ),
    );
  }
}
