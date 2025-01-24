import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiSample extends StatelessWidget {
  const ConfettiSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Confetti',
        home: Scaffold(
          backgroundColor: Colors.grey[900],
          body: MyApp(),
        ),
      );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(microseconds: 1));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    _controllerBottomCenter.dispose();

    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degrees to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  Path drawHeart(Size size) {
  final path = Path();
  final centerX = size.width / 2;
  final centerY = size.height / 2;
  final sizeFactor = size.width / 3; // Controls the size of the heart

  for (double t = 0; t <= 2 * pi; t += 0.01) {
    final x = sizeFactor * 16 * pow(sin(t), 3);
    final y = sizeFactor * (13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t));
    path.lineTo(centerX + x, centerY - y); // Subtract y to invert the axis
  }

  path.close();
  return path;
}

Path drawSpiral(Size size) {
  final path = Path();
  double radius = 0;
  double angle = 0;
  final maxRadius = size.width / 2;
  final stepSize = 2; // Controls how quickly the spiral spreads out

  path.moveTo(size.width / 2, size.height / 2);

  while (radius < maxRadius) {
    angle += 0.1;
    radius += stepSize;
    path.lineTo(
      size.width / 2 + radius * cos(angle),
      size.height / 2 + radius * sin(angle),
    );
  }

  return path;
}

Path drawFlower(Size size) {
  double degToRad(double deg) => deg * (pi / 180.0);

  final path = Path();
  final centerX = size.width / 2;
  final centerY = size.height / 2;
  final radius = size.width / 4;
  final angleStep = 360 / 100;

  for (int i = 0; i < 100; i++) {
    final angle = degToRad(i * angleStep);
    final petalX = centerX + radius * cos(angle);
    final petalY = centerY + radius * sin(angle);
    path.addOval(Rect.fromCircle(center: Offset(petalX, petalY), radius: radius));
  }

  return path;
}

Path drawPolygon(Size size) {
  double degToRad(double deg) => deg * (pi / 180.0);

  final halfWidth = size.width / 2;
  final radius = halfWidth;
  final degreesPerStep = degToRad(360 / 5);
  final path = Path();
  final fullAngle = degToRad(360);

  path.moveTo(halfWidth + radius * cos(0), halfWidth + radius * sin(0));

  for (double step = degreesPerStep; step <= fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + radius * cos(step), halfWidth + radius * sin(step));
  }

  path.close();
  return path;
}





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Scaffold(
      body:SafeArea(child: Stack(
        children: <Widget>[
          //CENTER -- Blast
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              shouldLoop:
                  true, // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
                Colors.yellow,
                Color.fromARGB(255, 1, 5, 12),
                Color.fromARGB(255, 248, 248, 250),
                Color.fromARGB(255, 59, 34, 9),
              ], // manually specify the colors to be used
              // createParticlePath: drawPolygon, // define a custom shape/path.
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                _controllerCenter.play();
              },
              child: _text('blast\nstars'),
            ),
          ),

          //CENTER RIGHT -- Emit left
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: _controllerCenterRight,
              blastDirection: pi, // radial value - LEFT
              particleDrag: 0.05, // apply drag to the confetti
              emissionFrequency: 0.05, // how often it should emit
              numberOfParticles: 20, // number of particles to emit
              gravity: 0.05, // gravity - or fall speed
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink
              ], // manually specify the colors to be used
              strokeWidth: 1,
              strokeColor: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                _controllerCenterRight.play();
              },
              child: _text('pump left'),
            ),
          ),

          //CENTER LEFT - Emit right
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: _controllerCenterLeft,
              blastDirection: 0, // radial value - RIGHT
              emissionFrequency: 0.6,
              // set the minimum potential size for the confetti (width, height)
              minimumSize: const Size(10, 10),
              // set the maximum potential size for the confetti (width, height)
              maximumSize: const Size(50, 50),
              numberOfParticles: 1,
              gravity: 0.1,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                _controllerCenterLeft.play();
              },
              child: _text('singles'),
            ),
          ),

          //TOP CENTER - shoot down
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerTopCenter,
              blastDirection: pi / 2,
              maxBlastForce: 5, // set a lower max blast force
              minBlastForce: 2, // set a lower min blast force
              emissionFrequency: 0.05,
              numberOfParticles: 50, // a lot of particles at once
              gravity: 1,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: TextButton(
                onPressed: () {
                  _controllerTopCenter.play();
                },
                child: _text('goliath')),
          ),
          //BOTTOM CENTER - Shoot up
          Align(
            alignment: Alignment.bottomCenter,
            child: ConfettiWidget(
              confettiController: _controllerBottomCenter,
              blastDirection: -pi / 2,
              emissionFrequency: 0.01,
              numberOfParticles: 20,
              maxBlastForce: 100,
              minBlastForce: 80,
              gravity: 0.3,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                _controllerBottomCenter.play();
              },
              child: _text('hard and infrequent'),
            ),
          ),
        ],
      ),
    )));
  }

  Text _text(String text) => Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 20),
      );
}

