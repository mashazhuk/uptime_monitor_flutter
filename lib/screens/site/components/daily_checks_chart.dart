import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyChecksChart extends StatelessWidget {
  final Map<int, double> responseTimes;

  const DailyChecksChart({Key? key, required this.responseTimes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (_) => FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 0.5,
          ),
          getDrawingVerticalLine: (_) => FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 0.5,
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, _) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value.toInt().toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide right axis
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide top axis
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, _) {
                Widget text;
                const style = TextStyle(color: Colors.white);
                print(value);
                switch (value.toInt()) {
                  case 100:
                    text = const Text('MAR', style: style);
                    break;
                  case 1440:
                    text = const Text('JUN', style: style);
                    break;
                  case 1440:
                    text = const Text('SEP', style: style);
                    break;
                  default:
                    text = const Text('', style: style);
                    break;
                }
                final int minutes = value.toInt();
                final int hours = minutes ~/ 60;
                final int remainingMinutes = minutes % 60;
                return text;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: responseTimes.entries
                .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                .toList(),
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
            barWidth: 2,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.2),
                  Colors.red.withOpacity(0.2),
                ],
              ),
            ),
          ),
        ],
        minX: 0,
        maxX: 1440,
        minY: 0, // Start Y-axis from 0
        maxY: responseTimes.values.reduce((a, b) => a > b ? a : b),
      ),
    );
  }
}
