import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart'; // Import Syncfusion package

class Donut extends StatefulWidget {
  const Donut({super.key});

  @override
  State<Donut> createState() => _DonutState();
}

class _DonutState extends State<Donut> {
  @override
  Widget build(BuildContext context) {
    const double defaultPadding = 16.0;

    return Scaffold( 
      appBar: AppBar(foregroundColor: AppColors.white,backgroundColor: Colors.teal,title: const Text('Donut',style: TextStyle(color: AppColors.white),)),
      body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            annotations: const <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    Text('25',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Text('Toatl Counts',style: TextStyle(fontSize: 18),)
                ],),
                angle: 360,
                positionFactor: .1,
                )
            ],
            interval: 5,
            radiusFactor: 0.5, // Adjust this to make the gauge look like a donut
            showLabels: false, // Hide labels
            showTicks: false, // Hide ticks
            startAngle: 67, // Start from top
            endAngle: 67, // Complete the circle
            pointers: const <GaugePointer>[
              RangePointer(
                value: 80, // The value of the donut (percentage)
                cornerStyle: CornerStyle.bothCurve, // Smooth rounded corners
                color: Color.fromARGB(255, 35, 172, 158), // Custom color for the range
                width: 10, // Width of the pointer (making the donut thickness)
              ),
            ],
          ),

          RadialAxis(
            radiusFactor: 0.6,
            showLabels: false,
            showTicks: false,
            startAngle: 20,
            endAngle: 20,
            pointers: const <GaugePointer>[
              RangePointer(
                value: 40,
                cornerStyle: CornerStyle.bothCurve,
                color: Colors.teal,
                width: 10,
              ),
            ],
            interval: 5,
          ),


           RadialAxis(
            radiusFactor: 0.7,
            showLabels: false,
            showTicks: false,
            startAngle: 320,
            endAngle: 320,
            pointers: const <GaugePointer>[
              RangePointer(
                value: 80,
                cornerStyle: CornerStyle.bothCurve,
                color: Color.fromARGB(255, 10, 209, 189),
                width: 10,
              ),
            ],
            interval: 5,
          ),



        ],
      ),
    )),
    );
  }
}
