import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Speedometer extends StatefulWidget {
  Speedometer({Key? key}) : super(key: key);

  @override
  _SpeedometerState createState() => _SpeedometerState();
}

class _SpeedometerState extends State<Speedometer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _radialGaugeAnimation;
  late Animation<double> _linearGaugeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _radialGaugeAnimation = Tween<double>(begin: 0.0, end: 90.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _linearGaugeAnimation = Tween<double>(begin: 0.0, end: 50.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _getGauge({bool isRadialGauge = true}) {
    // if (isRadialGauge) {
      return _getRadialGauge();
    // } 
    // else {
    //   return _getLinearGauge();
    // }
    // return sizeBox();
  }

  Widget _getRadialGauge() {
    return SfRadialGauge(
      title: const GaugeTitle(
        text: '',
        textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 150,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 50,
              color: Colors.green,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 50,
              endValue: 100,
              color: Colors.orange,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 100,
              endValue: 150,
              color: Colors.red,
              startWidth: 10,
              endWidth: 10,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(value: _radialGaugeAnimation.value),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  '${_radialGaugeAnimation.value.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        ),
      ],
    );
  }

  Widget _getLinearGauge() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SfLinearGauge(
        minimum: 0.0,
        maximum: 100.0,
        orientation: LinearGaugeOrientation.horizontal,
        majorTickStyle: const LinearTickStyle(length: 20),
        axisLabelStyle: const TextStyle(fontSize: 12.0, color: Colors.black),
        axisTrackStyle: const LinearAxisTrackStyle(
          color: Colors.cyan,
          edgeStyle: LinearEdgeStyle.bothFlat,
          thickness: 15.0,
          borderColor: Colors.grey,
        ),
        barPointers: <LinearBarPointer>[
          LinearBarPointer(value: _linearGaugeAnimation.value),
        ],
      ),
    );
  }

  Widget _getControlPanel() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Radial Gauge Value'),
              Slider(
                value: _radialGaugeAnimation.value,
                min: 0.0,
                max: 150.0,
                divisions: 150,
                label: _radialGaugeAnimation.value.toStringAsFixed(1),
                onChanged: (double newValue) {
                  setState(() {
                    _controller.stop();
                    _radialGaugeAnimation = Tween<double>(begin: 0.0, end: newValue)
                        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
                    _controller.forward();
                  });
                },
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     children: [
        //       const Text('Linear Gauge Value'),
        //       Slider(
        //         value: _linearGaugeAnimation.value,
        //         min: 0.0,
        //         max: 100.0,
        //         divisions: 100,
        //         label: _linearGaugeAnimation.value.toStringAsFixed(1),
        //         onChanged: (double newValue) {
        //           setState(() {
        //             _controller.stop();
        //             _linearGaugeAnimation = Tween<double>(begin: 0.0, end: newValue)
        //                 .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
        //             _controller.forward();
        //           });
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: AppColors.white,backgroundColor: Colors.teal,title: const Text('Animated Speedometer',style: TextStyle(color: AppColors.white),)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _getGauge(isRadialGauge: true)),
          _getControlPanel(),
        ],
      ),
    );
  }
}
