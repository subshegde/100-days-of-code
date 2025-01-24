import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';

class LineChartScreen extends StatefulWidget {
  const LineChartScreen({super.key});

  @override
  State<LineChartScreen> createState() => _LineChartScreenState();
}

class _LineChartScreenState extends State<LineChartScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Line Chart'),
        backgroundColor: AppColors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.black,
            width: width,
            height: height,
            child: const LineChartWidget(),
          ),
        ),
      ),
    );
  }
}

class Titles {
  FlTitlesData getTitleData() {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.green,
              ),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.green,
              ),
            );
          },
        ),
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true),
          titlesData: Titles().getTitleData(),
          borderData: FlBorderData(
            show: true, 
            border: Border.all(
              color: AppColors.green, 
              width: 1)),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 1),
                const FlSpot(1, 2),
                const FlSpot(2, 1.5),
                const FlSpot(3.0, 2.10),
                const FlSpot(3, 3),
                const FlSpot(4, 2.5),
              ],
              isCurved: true,
              color: AppColors.green,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true, 
                color: AppColors.green.withOpacity(0.3)),
            ),
          ],
        ),
      ),
    );
  }
}
