import 'package:fl_animated_linechart/chart/area_line_chart.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';

class FlAnimatedLineChart extends StatefulWidget {
  FlAnimatedLineChart({Key? key}) : super(key: key);

  @override
  _FlAnimatedLineChartState createState() => _FlAnimatedLineChartState();
}

class _FlAnimatedLineChartState extends State<FlAnimatedLineChart> {
  int chartIndex = 0;

  // Fake data generation methods moved here

  Map<DateTime, double> createLine2() {
    return {
      DateTime(2025, 1, 1): 1.0,
      DateTime(2025, 2, 1): 2.5,
      DateTime(2025, 3, 1): 3.2,
    };
  }

  Map<DateTime, double> createLine2_2() {
    return {
      DateTime(2025, 1, 1): 0.5,
      DateTime(2025, 2, 1): 1.0,
      DateTime(2025, 3, 1): 2.0,
    };
  }

  Map<DateTime, double> createLineAlmostSaveValues() {
    return {
      DateTime(2025, 1, 1): 1.5,
      DateTime(2025, 2, 1): 2.0,
      DateTime(2025, 3, 1): 2.5,
    };
  }

  Map<DateTime, double> yAxisUpperMaxMarkerLine() {
    return {
      DateTime(2025, 1, 1): 4.0,
      DateTime(2025, 2, 1): 4.5,
      DateTime(2025, 3, 1): 5.0,
    };
  }

  Map<DateTime, double> yAxisUpperMinMarkerLine() {
    return {
      DateTime(2025, 1, 1): 1.8,
      DateTime(2025, 2, 1): 2.2,
      DateTime(2025, 3, 1): 2.6,
    };
  }

  Map<DateTime, double> yAxisLowerMinMarkerLine() {
    return {
      DateTime(2025, 1, 1): 0.8,
      DateTime(2025, 2, 1): 1.0,
      DateTime(2025, 3, 1): 1.5,
    };
  }

  Map<DateTime, double> yAxisLowerMaxMarkerLine() {
    return {
      DateTime(2025, 1, 1): 3.0,
      DateTime(2025, 2, 1): 3.5,
      DateTime(2025, 3, 1): 4.0,
    };
  }

  Map<DateTime, double> createLine2_3() {
    return {
      DateTime(2025, 1, 1): 0.5,
      DateTime(2025, 2, 1): 1.2,
      DateTime(2025, 3, 1): 1.7,
    };
  }

  @override
  Widget build(BuildContext context) {
    Map<DateTime, double> line1 = createLine2();
    Map<DateTime, double> line2 = createLine2_2();
    Map<DateTime, double> line3 = yAxisUpperMaxMarkerLine();
    Map<DateTime, double> line4 = yAxisUpperMinMarkerLine();
    Map<DateTime, double> line5 = yAxisLowerMinMarkerLine();
    Map<DateTime, double> line6 = yAxisLowerMaxMarkerLine();
    Map<DateTime, double> line7 = createLine2_3();

    LineChart chart;

    // Prepare chart according to the selected chart index
    if (chartIndex == 0) {
      chart = LineChart.fromDateTimeMaps([
        line1,
        line2,
      ], [
        Colors.green,
        Colors.blue,
      ], [
        'C',
        'C',
      ], tapTextFontWeight: FontWeight.w400);
    } else if (chartIndex == 1) {
      chart = LineChart.fromDateTimeMaps(
        [createLineAlmostSaveValues()],
        [Colors.green],
        ['C'],
        tapTextFontWeight: FontWeight.w400,
      );
    } else if (chartIndex == 2) {
      chart = AreaLineChart.fromDateTimeMaps(
        [line1],
        [Colors.red.shade900],
        ['C'],
        yAxisName: "Temperature",
        gradients: [
          Pair(
            Colors.yellow.shade400, 
            Colors.red.shade700)],
      );
    } else {
      chart = LineChart.fromDateTimeMaps([
        line7,
        line3,
        line4,
        line5,
        line6,
      ], [
        Colors.blue,
        Colors.red,
        Colors.yellow,
        Colors.yellow,
        Colors.red,
      ], [
        'C',
        'C',
        'C',
        'C',
        'C',
      ], tapTextFontWeight: FontWeight.w400);
      chart.lines[1].isMarkerLine = true;
      chart.lines[2].isMarkerLine = true;
      chart.lines[3].isMarkerLine = true;
      chart.lines[4].isMarkerLine = true;
    }

    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      textStyle: const TextStyle(fontSize: 13),
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black45),
          borderRadius: BorderRadius.all(Radius.circular(3))),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fl Animated Line Chart'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                     TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 13),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: chartIndex == 0 ? 1.5 :1,
                            color: chartIndex == 0 ? AppColors.green : AppColors.grey,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: Text(
                        'LineChart',
                        style: TextStyle(
                          color: chartIndex == 0 ? AppColors.black : AppColors.black,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          chartIndex = 0;
                        });
                      },
                    ),

                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 13),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: chartIndex == 1 ? 1.5 :1,
                            color: chartIndex == 1 ? AppColors.green : AppColors.grey,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: Text(
                        'LineChart2',
                        style: TextStyle(
                          color: chartIndex == 1 ? AppColors.black : AppColors.black,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          chartIndex = 1;
                        });
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 13),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: chartIndex == 2 ? 1.5 :1,
                            color: chartIndex == 2 ? AppColors.green : AppColors.grey,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: Text(
                        'AreaChart',
                        style: TextStyle(
                          color: chartIndex == 2 ? AppColors.black : AppColors.black,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          chartIndex = 2;
                        });
                      },
                    ),
                     TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 13),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: chartIndex == 3 ? 1.5 :1,
                            color: chartIndex == 3 ? AppColors.green : AppColors.grey,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: Text(
                        'MarkerLines',
                        style: TextStyle(
                          color: chartIndex == 3 ? AppColors.black : AppColors.black,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          chartIndex = 3;
                        });
                      },
                    ),
                    ],
                  ),
                ),

              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedLineChart(
                  chart,
                  key: UniqueKey(),
                  gridColor: Colors.black54,
                  textStyle: const TextStyle(fontSize: 10, color: Colors.black54),
                  toolTipColor: Colors.white,
                  legends: chartIndex == 3
                      ? [
                          const Legend(
                            title: 'Critical',
                            color: Colors.red,
                            showLeadingLine: true,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          const Legend(
                            title: 'Warning',
                            color: Colors.yellow,
                            showLeadingLine: true,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          const Legend(
                            title: 'Warning',
                            color: Colors.yellow,
                            icon: Icon(
                              Icons.report_problem_rounded,
                              size: 17,
                              color: Colors.yellow,
                            ),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          const Legend(
                            title: 'Critical',
                            color: Colors.red,
                            showLeadingLine: true,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ]
                      : [],
                  showMarkerLines: chartIndex == 3 ? true : false,
                  verticalMarkerColor: chartIndex == 3 ? Colors.red : null,
                  verticalMarker: [
                    DateTime.parse('2025-02-20 13:08:00'),
                    DateTime.parse('2025-02-20 13:16:00')
                  ],
                  verticalMarkerIcon: const [
                    Icon(
                      Icons.cancel_rounded,
                      color: Colors.red,
                    ),
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                    ),
                  ],
                  iconBackgroundColor: Colors.white,
                  legendsRightLandscapeMode: true,
                ), //Unique key to force animations
              )),
              const SizedBox(width: 200, height: 50, child: Text('')),
            ]),
      ),
    );
  }
}
