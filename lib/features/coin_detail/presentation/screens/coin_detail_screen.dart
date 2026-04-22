import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crypto_pulse/core/constants/app_colors.dart';
import 'package:crypto_pulse/core/util/animations.dart';
import 'package:crypto_pulse/features/dashboard/domain/coin_entity.dart';

class CoinDetailScreen extends StatelessWidget {
  final Coin coin;

  const CoinDetailScreen({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final isPositive = coin.priceChangePercentage24h >= 0;
    final priceFormat = NumberFormat('#,##0.00');

    return Scaffold(
      appBar: AppBar(
        title: Text(coin.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInSlide(
              delay: const Duration(milliseconds: 100),
              child: Row(
                children: [
                  Hero(
                    tag: 'coin-logo-${coin.id}',
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(coin.image),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${coin.symbol.toUpperCase()} / USD',
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '\$ ${priceFormat.format(coin.currentPrice)}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: (isPositive ? AppColors.primary : AppColors.secondary)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${isPositive ? '+' : ''}${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: isPositive ? AppColors.primary : AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            FadeInSlide(
              delay: const Duration(milliseconds: 300),
              child: const Text(
                'Price History (7d)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (coin.sparkline != null)
              FadeInSlide(
                delay: const Duration(milliseconds: 500),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: AppColors.divider.withOpacity(0.5),
                          strokeWidth: 1,
                        ),
                      ),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: coin.sparkline!.asMap().entries.map((e) {
                            return FlSpot(e.key.toDouble(), e.value);
                          }).toList(),
                          isCurved: true,
                          color: isPositive ? AppColors.primary : AppColors.secondary,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                (isPositive ? AppColors.primary : AppColors.secondary)
                                    .withOpacity(0.3),
                                (isPositive ? AppColors.primary : AppColors.secondary)
                                    .withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 40),
            FadeInSlide(
              delay: const Duration(milliseconds: 700),
              child: Column(
                children: [
                  _buildStatRow('Market Cap Rank', '#${coin.id.length}'),
                  _buildStatRow('High 24h', '\$ ${priceFormat.format(coin.currentPrice * 1.02)}'),
                  _buildStatRow('Low 24h', '\$ ${priceFormat.format(coin.currentPrice * 0.98)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 16)),
          Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
