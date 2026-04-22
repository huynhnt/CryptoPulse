import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:crypto_pulse/core/constants/app_colors.dart';

class MiniChart extends StatelessWidget {
  final List<double> data;
  final bool isPositive;

  const MiniChart({
    super.key,
    required this.data,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 40,
      width: 80,
      child: LineChart(
        LineChartData(
          gridData:  FlGridData(show: false),
          titlesData:  FlTitlesData(show: false),
          borderData:  FlBorderData(show: false),
          minX: 0,
          maxX: data.length.toDouble() - 1,
          lineBarsData: [
            LineChartBarData(
              spots: data.asMap().entries.map((e) {
                return FlSpot(e.key.toDouble(), e.value);
              }).toList(),
              isCurved: true,
              color: isPositive ? AppColors.primary : AppColors.secondary,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: (isPositive ? AppColors.primary : AppColors.secondary)
                    .withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
