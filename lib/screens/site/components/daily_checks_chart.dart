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
              reservedSize: 50,
              getTitlesWidget: (value, _) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  value.toInt().toString()+"ms",
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 120,
              getTitlesWidget: (value, _) {
                if (responseTimes.keys.contains(value.toInt())) {
                  final style = TextStyle(color: Colors.white, fontSize: 12);
                  final int hours = value ~/ 60;
                  final int minutes = value.toInt() % 60;
                  final String label =
                      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(label, style: style),
                  );
                }
                return const SizedBox.shrink();
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
        minX: responseTimes.keys.reduce((a, b) => a < b ? a : b).toDouble(),
        maxX: responseTimes.keys.reduce((a, b) => a > b ? a : b).toDouble() < 1440
            ? responseTimes.keys.reduce((a, b) => a > b ? a : b).toDouble()
            : 1440,
        minY: 0,
        maxY: responseTimes.values.reduce((a, b) => a > b ? a : b),
      ),
      duration: Duration(milliseconds: 150),// Optional
      curve: Curves.linear,

    );
  }
}
