import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyChecksChart extends StatefulWidget {
  final Map<int, double> responseTimes;

  const DailyChecksChart({Key? key, required this.responseTimes}) : super(key: key);

  @override
  _DailyChecksChartState createState() => _DailyChecksChartState();
}

class _DailyChecksChartState extends State<DailyChecksChart> {
  @override
  Widget build(BuildContext context) {
    return Text("Charttt");
    // return LineChart(
    //   LineChartData(
    //     lineBarsData: [
    //       LineChartBarData(
    //         spots: widget.responseTimes.entries
    //             .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
    //             .toList(),
    //         isCurved: true,
    //         color: Colors.blue,
    //         barWidth: 3,
    //         isStrokeCapRound: true,
    //         belowBarData: BarAreaData(show: false),
    //       ),
    //     ],
    //     titlesData: FlTitlesData(
    //       leftTitles: const AxisTitles(
    //         sideTitles: SideTitles(showTitles: true),
    //       ),
    //       bottomTitles: AxisTitles(
    //         sideTitles: SideTitles(
    //           showTitles: true,
    //           getTitlesWidget: (value, meta) {
    //             return Text(
    //               '${value.toInt()}:00',
    //               style: TextStyle(fontSize: 10),
    //             );
    //           },
    //         ),
    //       ),
    //     ),
    //     borderData: FlBorderData(show: true),
    //     gridData: FlGridData(show: true),
    //   ),
    // );
  }
}
