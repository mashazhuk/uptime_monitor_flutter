import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyChecksChart extends StatefulWidget {
  final Map<int, double> responseTimes;

  const DailyChecksChart({Key? key, required this.responseTimes}) : super(key: key);

  @override
  _DailyChecksChartState createState() => _DailyChecksChartState();
}

class _DailyChecksChartState extends State<DailyChecksChart> {
  var baselineX = 0.0;
  var baselineY = 0.0;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    baselineX = now.hour * 60 + now.minute.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 18.0,
          right: 18.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  RotatedBox(
                    quarterTurns: 1,
                    child: Slider(
                      value: baselineY,
                      onChanged: (newValue) {
                        setState(() {
                          baselineY = newValue;
                        });
                      },
                      min: 0,
                      max: widget.responseTimes.values.reduce((a, b) => a > b ? a : b),
                    ),
                  ),
                  Expanded(
                    child: _Chart(
                      baselineX,
                      baselineY,
                      widget.responseTimes,
                    ),
                  )
                ],
              ),
            ),
            Slider(
              value: baselineX,
              onChanged: (newValue) {
                setState(() {
                  baselineX = newValue;
                });
              },
              min: 0,
              max: 1440, // 24 hours * 60 minutes
            ),
          ],
        ),
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  final double baselineX;
  final double baselineY;
  final Map<int, double> responseTimes;

  const _Chart(this.baselineX, this.baselineY, this.responseTimes) : super();

  Widget getHorizontalTitles(value, TitleMeta meta) {
    TextStyle style;
    if ((value - baselineX).abs() <= 0.1) {
      style = const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );
    } else {
      style = const TextStyle(
        color: Colors.white60,
        fontSize: 14,
      );
    }
    final int minutes = value.toInt();
    final int hours = minutes ~/ 60;
    final int remainingMinutes = minutes % 60;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        '${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}',
        style: style,
      ),
    );
  }

  Widget getVerticalTitles(value, TitleMeta meta) {
    TextStyle style;
    if ((value - baselineY).abs() <= 0.1) {
      style = const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );
    } else {
      style = const TextStyle(
        color: Colors.white60,
        fontSize: 14,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(meta.formattedValue, style: style),
    );
  }

  FlLine getHorizontalVerticalLine(double value) {
    if ((value - baselineY).abs() <= 0.1) {
      return const FlLine(
        color: Colors.white70,
        strokeWidth: 1,
        dashArray: [8, 4],
      );
    } else {
      return const FlLine(
        color: Colors.blueGrey,
        strokeWidth: 0.4,
        dashArray: [8, 4],
      );
    }
  }

  FlLine getVerticalVerticalLine(double value) {
    if ((value - baselineX).abs() <= 0.1) {
      return const FlLine(
        color: Colors.white70,
        strokeWidth: 1,
        dashArray: [8, 4],
      );
    } else {
      return const FlLine(
        color: Colors.blueGrey,
        strokeWidth: 0.4,
        dashArray: [8, 4],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
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
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.3),
                  Colors.red.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getVerticalTitles,
              reservedSize: 36,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getHorizontalTitles,
              reservedSize: 32,
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: getHorizontalVerticalLine,
          getDrawingVerticalLine: getVerticalVerticalLine,
        ),
        minY: 0,
        maxY: responseTimes.values.reduce((a, b) => a > b ? a : b),
        baselineY: baselineY,
        minX: 0,
        maxX: 1440, // 24 hours * 60 minutes
        baselineX: baselineX,
      ),
      duration: Duration.zero,
    );
  }
}
