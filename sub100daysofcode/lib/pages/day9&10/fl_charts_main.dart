import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';
import 'package:sub100daysofcode/pages/day9&10/fl_animated_line_chart.dart';
import 'package:sub100daysofcode/pages/day9&10/lineChart.dart';

class FlowCharts extends StatefulWidget {
  const FlowCharts({super.key});

  @override
  State<FlowCharts> createState() => _FlowChartsState();
}

class _FlowChartsState extends State<FlowCharts> {

    final List<Map<String, dynamic>> buttonData = [
   
    {"title": "Line Chart", "content": "", "screen": const LineChartScreen()},
    {"title": "Fl Animated Line Chart", "content": "", "screen": FlAnimatedLineChart()},
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(centerTitle: true,title: const Text('Flow Charts',style: TextStyle(color: AppColors.black),),backgroundColor: AppColors.white,),
      body: SafeArea(
        child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: buttonData.length,
        itemBuilder: (context, index) {
          var button = buttonData[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => button["screen"]),
              );
            },
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      button["title"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(button["content"]!),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      ),
    );
  }
}