import 'package:flutter/material.dart';
import 'package:crypto_pulse/core/constants/app_colors.dart';
import 'package:crypto_pulse/features/wallet/domain/wallet_entities.dart';
import 'package:intl/intl.dart';

class TransactionHistoryItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionHistoryItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isDeposit = transaction.type == TransactionType.deposit;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (isDeposit ? AppColors.primary : AppColors.secondary).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDeposit ? Icons.south_west_rounded : Icons.north_east_rounded,
              color: isDeposit ? AppColors.primary : AppColors.secondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  DateFormat('MMM dd, yyyy • HH:mm').format(transaction.date),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isDeposit ? '+' : '-'}${transaction.amount} ${transaction.coinSymbol}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDeposit ? AppColors.primary : AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
