import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:crypto_pulse/core/constants/app_colors.dart';
import 'package:crypto_pulse/core/util/animations.dart';
import 'package:crypto_pulse/features/dashboard/domain/coin_entity.dart';
import 'package:crypto_pulse/features/dashboard/presentation/providers/coin_provider.dart';

class CoinDetailScreen extends ConsumerStatefulWidget {
  final Coin coin;

  const CoinDetailScreen({super.key, required this.coin});

  @override
  ConsumerState<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends ConsumerState<CoinDetailScreen> {
  double? _hoveredPrice;
  DateTime? _hoveredDate;
  String _selectedTimeframe = '7D';
  List<double>? _customChartData;
  bool _isLoadingChart = false;

  Future<void> _fetchChartData(String timeframe) async {
    setState(() {
      _isLoadingChart = true;
      _selectedTimeframe = timeframe;
    });

    try {
      String days = '7';
      switch (timeframe) {
        case '1H': days = '1'; break;
        case '24H': days = '1'; break;
        case '7D': days = '7'; break;
        case '1M': days = '30'; break;
        case '1Y': days = '365'; break;
      }

      final repository = ref.read(coinRepositoryProvider);
      var prices = await repository.getMarketChart(widget.coin.id, days);

      if (timeframe == '1H') {
        // Lấy 1 giờ cuối (khoảng 12 điểm)
        if (prices.length > 12) {
          prices = prices.sublist(prices.length - 12);
        }
      }

      setState(() {
        _customChartData = prices;
        _isLoadingChart = false;
      });
    } catch (e) {
      setState(() => _isLoadingChart = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi tải biểu đồ: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final coin = widget.coin;
    final chartData = _customChartData ?? coin.sparkline ?? [];
    
    final isPositive = coin.priceChangePercentage24h >= 0;
    
    // Định dạng giá thông minh
    final NumberFormat priceFormat;
    if (coin.currentPrice < 1) {
      priceFormat = NumberFormat('#,##0.000000');
    } else if (coin.currentPrice < 100) {
      priceFormat = NumberFormat('#,##0.0000');
    } else {
      priceFormat = NumberFormat('#,##0.00');
    }
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    final displayPrice = _hoveredPrice ?? coin.currentPrice;
    final displayDate = _hoveredDate;

    // Tính toán mốc lưới dọc (Y-axis)
    double? minY, maxY, horizontalInterval;
    if (chartData.isNotEmpty) {
      minY = chartData.reduce((a, b) => a < b ? a : b);
      maxY = chartData.reduce((a, b) => a > b ? a : b);
      final range = maxY - minY;
      horizontalInterval = range > 0 ? range / 4 : 1.0;
    }

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
                  Expanded(
                    child: Column(
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
                          '\$ ${priceFormat.format(displayPrice)}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Visibility(
                          visible: displayDate != null,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Text(
                            displayDate != null
                                ? dateFormat.format(displayDate!)
                                : '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
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
              child: Text(
                'Biến động giá ($_selectedTimeframe)',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (chartData.isNotEmpty)
              FadeInSlide(
                delay: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Stack(
                        children: [
                          LineChart(
                            LineChartData(
                              lineTouchData: LineTouchData(
                                handleBuiltInTouches: true,
                                touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                                  if (event is FlPanEndEvent || event is FlTapUpEvent || event is FlPointerExitEvent) {
                                    setState(() {
                                      _hoveredPrice = null;
                                      _hoveredDate = null;
                                    });
                                    return;
                                  }

                                  if (response == null || response.lineBarSpots == null || response.lineBarSpots!.isEmpty) {
                                    return;
                                  }

                                  final spot = response.lineBarSpots!.first;
                                  final index = spot.spotIndex;
                                  final price = spot.y;
                                  
                                  // Ước tính date
                                  final now = DateTime.now();
                                  final totalPoints = chartData.length;
                                  Duration interval;
                                  switch (_selectedTimeframe) {
                                    case '1H': interval = const Duration(minutes: 5); break;
                                    case '24H': interval = const Duration(minutes: 5); break;
                                    case '7D': interval = const Duration(hours: 1); break;
                                    case '1M': interval = const Duration(hours: 1); break;
                                    case '1Y': interval = const Duration(days: 1); break;
                                    default: interval = const Duration(hours: 1);
                                  }
                                  final date = now.subtract(interval * (totalPoints - 1 - index));

                                  if (price != _hoveredPrice) {
                                    HapticFeedback.selectionClick();
                                    setState(() {
                                      _hoveredPrice = price;
                                      _hoveredDate = date;
                                    });
                                  }
                                },
                                getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                                  return spotIndexes.map((index) {
                                    return TouchedSpotIndicatorData(
                                      FlLine(
                                        color: AppColors.textSecondary.withOpacity(0.3),
                                        strokeWidth: 2,
                                        dashArray: [5, 5],
                                      ),
                                      FlDotData(
                                        show: true,
                                        getDotPainter: (spot, percent, barData, index) =>
                                            FlDotCirclePainter(
                                          radius: 6,
                                          color: isPositive ? AppColors.primary : AppColors.secondary,
                                          strokeWidth: 2,
                                          strokeColor: Colors.white,
                                        ),
                                      ),
                                    );
                                  }).toList();
                                },
                                touchTooltipData: LineTouchTooltipData(
                                  showOnTopOfTheChartBoxArea: false,
                                  maxContentWidth: 0,
                                  tooltipRoundedRadius: 0,
                                  getTooltipColor: (spot) => Colors.transparent,
                                  getTooltipItems: (touchedSpots) => touchedSpots.map((spot) => null).toList(),
                                ),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                drawHorizontalLine: true,
                                horizontalInterval: horizontalInterval,
                                getDrawingHorizontalLine: (value) => FlLine(
                                  color: Colors.white.withOpacity(0.15),
                                  strokeWidth: 1,
                                  dashArray: [5, 5],
                                ),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 45,
                                    interval: horizontalInterval,
                                    getTitlesWidget: (value, meta) {
                                      return SideTitleWidget(
                                        meta: meta,
                                        child: Text(
                                          priceFormat.format(value),
                                          style: const TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: 9,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30,
                                    interval: (chartData.length / 6).clamp(1, double.infinity),
                                    getTitlesWidget: (value, meta) {
                                      final index = value.toInt();
                                      if (index < 0 || index >= chartData.length) return const SizedBox();
                                      
                                      final now = DateTime.now();
                                      Duration interval;
                                      switch (_selectedTimeframe) {
                                        case '1H': interval = const Duration(minutes: 5); break;
                                        case '24H': interval = const Duration(minutes: 5); break;
                                        case '7D': interval = const Duration(hours: 1); break;
                                        case '1M': interval = const Duration(hours: 1); break;
                                        case '1Y': interval = const Duration(days: 1); break;
                                        default: interval = const Duration(hours: 1);
                                      }
                                      final date = now.subtract(interval * (chartData.length - 1 - index));
                                      
                                      String label;
                                      if (_selectedTimeframe == '1H' || _selectedTimeframe == '24H') {
                                        label = DateFormat('HH:mm').format(date);
                                      } else {
                                        label = DateFormat('dd/MM').format(date);
                                      }

                                      return SideTitleWidget(
                                        meta: meta,
                                        child: Text(
                                          label,
                                          style: const TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: 10,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: chartData.asMap().entries.map((e) {
                                    return FlSpot(e.key.toDouble(), e.value);
                                  }).toList(),
                                  isCurved: true,
                                  curveSmoothness: 0.1,
                                  color: isPositive ? AppColors.primary : AppColors.secondary,
                                  barWidth: 2.5,
                                  isStrokeCapRound: true,
                                  dotData: const FlDotData(show: false),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        (isPositive ? AppColors.primary : AppColors.secondary)
                                            .withOpacity(0.2),
                                        (isPositive ? AppColors.primary : AppColors.secondary)
                                            .withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_isLoadingChart)
                            const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTimeframeSelector(),
                  ],
                ),
              ),
            const SizedBox(height: 40),
            FadeInSlide(
              delay: const Duration(milliseconds: 700),
              child: Column(
                children: [
                  _buildStatRow('Market Cap Rank', '#${coin.marketCapRank}'),
                  if (chartData.isNotEmpty) ...[
                    _buildStatRow('Thị giá (${_selectedTimeframe}) - Cao', '\$ ${priceFormat.format(
                      chartData.reduce((a, b) => a > b ? a : b)
                    )}'),
                    _buildStatRow('Thị giá (${_selectedTimeframe}) - Thấp', '\$ ${priceFormat.format(
                      chartData.reduce((a, b) => a < b ? a : b)
                    )}'),
                  ],
                  _buildStatRow(
                    'Tổng cung',
                    coin.totalSupply != null
                        ? '${NumberFormat('#,###').format(coin.totalSupply)} ${coin.symbol.toUpperCase()}'
                        : 'N/A',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    final timeframes = ['1H', '24H', '7D', '1M', '1Y'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: timeframes.map((tf) {
        final isSelected = _selectedTimeframe == tf;
        return GestureDetector(
          onTap: () {
            if (!isSelected && !_isLoadingChart) {
              _fetchChartData(tf);
              HapticFeedback.lightImpact();
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.divider,
              ),
            ),
            child: Text(
              tf,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
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
