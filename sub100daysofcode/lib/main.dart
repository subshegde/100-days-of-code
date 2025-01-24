import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';
import 'package:sub100daysofcode/pages/day18TopSnippingSheet/bottomSnippingSheet.dart';
import 'package:sub100daysofcode/pages/day22SlideAction/slideAction.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/home/homeMain.dart';
import 'package:sub100daysofcode/pages/day30SchedulePushNotification/services/notificationServices.dart';
import 'package:sub100daysofcode/pages/day31/catchedNetworkImage.dart';
import 'package:sub100daysofcode/pages/day33-Streams/streams.dart';
import 'package:sub100daysofcode/pages/home.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.white,
      debugShowCheckedModeBanner: false,
      title: '100 Days',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(background: kPrimaryColor),
        useMaterial3: true,
      ),
      // home: ButtonGrid(),
      home: StreamsExample(),
    );
  }
}
