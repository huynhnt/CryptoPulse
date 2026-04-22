import 'package:flutter/material.dart';
import 'package:crypto_pulse/core/constants/app_colors.dart';
import 'package:intl/intl.dart';

class WalletCard extends StatelessWidget {
  final String name;
  final double balance;
  final String symbol;
  final Color color;

  const WalletCard({
    super.key,
    required this.name,
    required this.balance,
    required this.symbol,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color,
            color.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(Icons.wallet, color: Colors.white70),
            ],
          ),
          const Spacer(),
          Text(
            symbol == 'USD' 
                ? '\$ ${NumberFormat('#,##0.00').format(balance)}'
                : '${balance.toStringAsFixed(4)} $symbol',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Available Balance',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
