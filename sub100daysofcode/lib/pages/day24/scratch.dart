import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:sub100daysofcode/constants/appColors.dart';


class ScratcherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.white,
        backgroundColor: Colors.teal,
        title: const Text('Scratcher',style: TextStyle(color: AppColors.white),),
      ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Scratcher(
                        brushSize: 15,
                        accuracy: ScratchAccuracy.low,
                        color: Colors.blueGrey,
                        image: Image.asset('assets/day24/scratch.png'),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/day24/car.png"),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ));
   
  }
}