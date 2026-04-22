import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto_pulse/core/constants/app_colors.dart';
import 'package:crypto_pulse/core/util/animations.dart';
import 'package:crypto_pulse/features/wallet/presentation/providers/wallet_provider.dart';
import 'package:crypto_pulse/features/wallet/presentation/widgets/wallet_card.dart';
import 'package:crypto_pulse/features/wallet/presentation/widgets/transaction_history_item.dart';
import 'package:crypto_pulse/features/wallet/presentation/widgets/deposit_dialog.dart';
import 'package:intl/intl.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(walletAccountsProvider);
    final transactionsAsync = ref.watch(walletTransactionsProvider);
    final totalBalance = ref.watch(totalWalletBalanceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet Hub'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.qr_code_scanner_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Balance Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FadeInSlide(
                delay: const Duration(milliseconds: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Assets Value',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$ ${NumberFormat('#,##0.00').format(totalBalance)}',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Action Buttons Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FadeInSlide(
                delay: const Duration(milliseconds: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton(
                      context, 
                      'Deposit', 
                      Icons.add_rounded, 
                      AppColors.primary,
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => const DepositDialog(),
                      ),
                    ),
                    _buildActionButton(context, 'Withdraw', Icons.remove_rounded, AppColors.secondary),
                    _buildActionButton(context, 'Transfer', Icons.swap_horiz_rounded, Colors.blueAccent),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Horizontal Wallet Cards
            FadeInSlide(
              delay: const Duration(milliseconds: 300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Your Accounts',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180,
                    child: accountsAsync.when(
                      data: (accounts) => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: accounts.length,
                        itemBuilder: (context, index) {
                          final account = accounts[index];
                          return WalletCard(
                            name: account.name,
                            balance: account.balance,
                            symbol: account.coinSymbol,
                            color: Color(int.parse(account.color)),
                          );
                        },
                      ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, _) => Center(child: Text('Error: $err')),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Transaction History Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FadeInSlide(
                delay: const Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Transactions',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 16),
                    transactionsAsync.when(
                      data: (transactions) => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          return TransactionHistoryItem(transaction: transactions[index]);
                        },
                      ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, _) => Center(child: Text('Error: $err')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, IconData icon, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
