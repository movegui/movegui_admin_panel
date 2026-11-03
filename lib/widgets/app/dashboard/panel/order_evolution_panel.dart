import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_page.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashbord_cards.dart';

class OrderEvolutionPanel extends StatelessWidget {
  const OrderEvolutionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return DashBordCards(
      title: 'Évolution des commandes',
      icon: Icons.trending_up,
      trailing: DropdownButton<String>(
        value: '7 jours',
        underline: const SizedBox(),
        items: const [
          DropdownMenuItem(value: '7 jours', child: Text('7 derniers jours')),
          DropdownMenuItem(value: '30 jours', child: Text('30 derniers jours')),
        ],
        onChanged: (_) {},
      ),
      child: SizedBox(
        height: 210,
        child: Center(
          child: Icon(
            Icons.show_chart,
            size: 100,
            color: Theme.of(context).primaryColor.withValues(alpha: .7),
          ),
        ),
      ),
    );
  }

  /* 

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OrdersEvolutionCard extends StatefulWidget {
  const OrdersEvolutionCard({super.key});

  @override
  State<OrdersEvolutionCard> createState() =>
      _OrdersEvolutionCardState();
}

class _OrdersEvolutionCardState
    extends State<OrdersEvolutionCard> {
  String selectedPeriod = '7 jours';

  static const burgundy = Color(0xFFA3171F);
  static const navy = Color(0xFF14244A);

  final spots = const <FlSpot>[
    FlSpot(0, 40),
    FlSpot(1, 62),
    FlSpot(2, 73),
    FlSpot(3, 57),
    FlSpot(4, 81),
    FlSpot(5, 86),
    FlSpot(6, 101),
    FlSpot(7, 136),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE4E8F0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 22),
          Expanded(
            child: LineChart(
              _chartData(),
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(
          Icons.trending_up_rounded,
          color: burgundy,
          size: 23,
        ),
        const SizedBox(width: 9),

        const Expanded(
          child: Text(
            'Évolution des commandes',
            style: TextStyle(
              color: burgundy,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFFDCE2EA),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedPeriod,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20,
              ),
              style: const TextStyle(
                color: navy,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              items: const [
                DropdownMenuItem(
                  value: '7 jours',
                  child: Text('7 derniers jours'),
                ),
                DropdownMenuItem(
                  value: '30 jours',
                  child: Text('30 derniers jours'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedPeriod = value;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  LineChartData _chartData() {
    return LineChartData(
      minX: 0,
      maxX: 7,
      minY: 0,
      maxY: 200,

      // Interaction souris sur Flutter Web
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (_) => navy,
          getTooltipItems: (spots) {
            return spots.map((spot) {
              return LineTooltipItem(
                '${spot.y.toInt()} commandes',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              );
            }).toList();
          },
        ),
      ),

      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 50,
        verticalInterval: 1,
        getDrawingHorizontalLine: (_) {
          return const FlLine(
            color: Color(0xFFE8ECF2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (_) {
          return const FlLine(
            color: Color(0xFFF0F2F6),
            strokeWidth: 1,
          );
        },
      ),

      borderData: FlBorderData(
        show: true,
        border: const Border(
          left: BorderSide(
            color: Color(0xFFDCE1E8),
          ),
          bottom: BorderSide(
            color: Color(0xFFDCE1E8),
          ),
        ),
      ),

      titlesData: FlTitlesData(
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),

        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            interval: 50,
            getTitlesWidget: (value, meta) {
              return SideTitleWidget(
                meta: meta,
                child: Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
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
            interval: 1,
            getTitlesWidget: (value, meta) {
              const labels = [
                '',
                '20 avr.',
                '21 avr.',
                '22 avr.',
                '23 avr.',
                '24 avr.',
                '25 avr.',
                '26 avr.',
              ];

              final index = value.toInt();

              if (index < 0 || index >= labels.length) {
                return const SizedBox.shrink();
              }

              return SideTitleWidget(
                meta: meta,
                space: 8,
                child: Text(
                  labels[index],
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF64748B),
                  ),
                ),
              );
            },
          ),
        ),
      ),

      lineBarsData: [
        LineChartBarData(
          spots: spots,

          color: burgundy,
          barWidth: 2.5,

          isCurved: true,
          curveSmoothness: 0.25,

          isStrokeCapRound: true,

          dotData: FlDotData(
            show: true,
            getDotPainter: (
              spot,
              percent,
              barData,
              index,
            ) {
              return FlDotCirclePainter(
                radius: 4,
                color: burgundy,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),

          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                burgundy.withValues(alpha: 0.18),
                burgundy.withValues(alpha: 0.01),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


*/
}
