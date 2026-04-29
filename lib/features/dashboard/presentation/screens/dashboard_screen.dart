import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto_pulse/core/constants/app_colors.dart';
import 'package:crypto_pulse/core/util/animations.dart';
import 'package:crypto_pulse/features/dashboard/presentation/widgets/balance_card.dart';
import 'package:crypto_pulse/features/dashboard/presentation/widgets/promo_banner.dart';
import 'package:crypto_pulse/features/dashboard/presentation/widgets/coin_list_item.dart';
import 'package:crypto_pulse/features/dashboard/presentation/providers/coin_provider.dart';
import 'package:crypto_pulse/features/dashboard/presentation/screens/all_coins_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lắng nghe danh sách đã lọc thay vì danh sách gốc
    final coinsAsync = ref.watch(filteredCoinsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CryptoPulse'),
        actions: [
          IconButton(
            onPressed: () => ref.refresh(topCoinsProvider),
            icon: const Icon(Icons.refresh_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: coinsAsync.when(
        data: (coins) => RefreshIndicator(
          onRefresh: () async => ref.refresh(topCoinsProvider),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FadeInSlide(
                  delay: Duration(milliseconds: 100),
                  child: BalanceCard(),
                ),
                const SizedBox(height: 20),
                const FadeInSlide(
                  delay: Duration(milliseconds: 300),
                  child: PromoBanner(),
                ),
                const SizedBox(height: 24),
                // Thanh tìm kiếm mới
                FadeInSlide(
                  delay: const Duration(milliseconds: 400),
                  child: TextField(
                    onChanged: (value) => 
                        ref.read(searchQueryProvider.notifier).state = value,
                    decoration: InputDecoration(
                      hintText: 'Search your favorite coin...',
                      prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeInSlide(
                  delay: const Duration(milliseconds: 500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Market Highlights',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AllCoinsScreen(),
                            ),
                          );
                        },
                        child: const Text('See all'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                if (coins.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text('No coins found'),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: coins.length,
                    itemBuilder: (context, index) {
                      final coin = coins[index];
                      return FadeInSlide(
                        delay: Duration(milliseconds: 600 + (index * 50)),
                        duration: const Duration(milliseconds: 500),
                        child: CoinListItem(coin: coin),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.secondary, size: 48),
              const SizedBox(height: 16),
              Text('Error: $err', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(topCoinsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
