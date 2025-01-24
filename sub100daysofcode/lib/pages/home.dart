import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';
import 'package:sub100daysofcode/pages/day11/webview_flutter.dart';
import 'package:sub100daysofcode/pages/day12/galleryMultipleImageSelection.dart';
import 'package:sub100daysofcode/pages/day13%20rive%20Flutter/rive_main.dart';
import 'package:sub100daysofcode/pages/day15/features/home/ui/blocHome.dart';
import 'package:sub100daysofcode/pages/day16_speedoMeter/speedoMeter.dart';
import 'package:sub100daysofcode/pages/day24/scratch.dart';
import 'package:sub100daysofcode/pages/day25Flutter_confitte/flutter_confetti.dart';
import 'package:sub100daysofcode/pages/day26_SpeechRecognition/speechRecognition.dart';
import 'package:sub100daysofcode/pages/day27Swipable_animation/swipeableButtonAnimation.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/home/homeMain.dart';
import 'package:sub100daysofcode/pages/day30SchedulePushNotification/pages/notification.dart';
import 'package:sub100daysofcode/pages/day31-tutorial%20coach%20mark/coachMark.dart';
import 'package:sub100daysofcode/pages/day32%20persistent%20bottom%20nav%20bar/persistentBottomNavBar.dart';
import 'package:sub100daysofcode/pages/day8/glassmorphism.dart';
import 'package:sub100daysofcode/pages/day9&10/fl_animated_line_chart.dart';
import 'package:sub100daysofcode/pages/day9&10/lineChart.dart';

class ButtonGrid extends StatefulWidget {
  @override
  _ButtonGridState createState() => _ButtonGridState();
}

class _ButtonGridState extends State<ButtonGrid> {
  final List<Map<String, dynamic>> buttonData = [
    {"title": "Day 1", "content": "Day 1", "screen": '',},
    {"title": "Day 2", "content": "Day 2", "screen": '',},
    {"title": "Day 3", "content": "Day 3", "screen": '', },
    {"title": "Day 4", "content": "Day 4", "screen": '', },
    {"title": "Day 5", "content": "Day 5", "screen": '', },
    {"title": "Day 6", "content": "Day 6", "screen": '',},
    {"title": "Day 7", "content": "Day 7", "screen": '', },
    {"title": "Glassmorphism", "content": "Day 8", "screen": GlassmorphicSample(),},
    {"title": "Line Chart", "content": "Day 9", "screen": const LineChartScreen(), },
    {"title": "Fl Animated Line Chart", "content": "Day 10", "screen": FlAnimatedLineChart(), },
    {"title": "Web View Flutter", "content": "Day 11", "screen": const WebViewFlutter(),},
    {"title": "Multiple Image Selection", "content": "Day 12", "screen": const Gallery(),},
    {"title": "Rive Demo", "content": "Day 13", "screen": const HomePageRive(),},
    {"title": "Bloc", "content": "Day 15", "screen": const BlocHome(), },
    {"title": "Animated Speedo Meter", "content": "Day 16", "screen": Speedometer(),},
    {"title": "Scratcher", "content": "Day 24", "screen": ScratcherPage(),},
    {"title": "Confetti", "content": "Day 25", "screen": const ConfettiSample(),},
    {"title": "Speech to Text", "content": "Day 25", "screen": const SpeechSampleApp(),},
    {"title": "Speech To Text", "content": "Day 26", "screen": SpeechSampleApp(),},
    {"title": "Shimmer Buttons", "content": "Day 27", "screen": SwipeableButtonAnimation(),},
    {"title": "Youtube", "content": "Day 29", "screen": HomeMainPage(),},
    {"title": "Schedule Push Notification", "content": "Day 30", "screen": SchedulePushNotificationDay30(title: '',),},
    {"title": "Tutorial Coach Mark", "content": "Day 31", "screen": BottomNavigationBarExample(),},
    {"title": "Persistent Bottom Nav Bar", "content": "Day 32", "screen": const MyAppPersistentBottomNavBar(),},
    // {"title": "Login Page", "content": "Day 17", "screen": const LoginPageDay17(), },
    // {"title": "Top Snipping Sheet", "content": "Day 18", "screen": AbovePage(),},
    // {"title": "Bottom Snipping Sheet", "content": "Day 18", "screen": BottomSnippingSheet(),},
    // {"title": "Youtube Player", "content": "Day 19", "screen": const YoutubePlayerPage(),},
    // {"title": "Url Launcher", "content": "Day 20", "screen": CallPhone(),},
    // {"title": "Animated Speedo Meter", "content": "Day 21", "screen": Speedometer(),},
    // {"title": "Donut", "content": "Day 22", "screen": const Donut(),},
    // {"title": "Slide Action", "content": "Day 23", "screen": const SlideToPerformExample(),},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('100 Days Of Code',style: TextStyle(color: AppColors.white),),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
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
              elevation: 8,
              color: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Text(
                      button["content"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    Text(
                      button["title"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
