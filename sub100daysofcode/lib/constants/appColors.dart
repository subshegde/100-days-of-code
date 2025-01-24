import 'package:flutter/material.dart';
import 'package:sub100daysofcode/utils/helper.dart';

const Color kPrimaryColor = Color(0xffd6e2ea);
const Color kTextBgColor = Color.fromARGB(197, 176, 72, 100);
final Color? kTextBgColors = Colors.red[50];
const Color kSecondaryColor = Color(0xffB04863);


class AppColors {
  AppColors._();

  static const int primaryColor = 0xff6ACAC6;
  static const int primaryColorDark = 0xff08ACA5;

  static MaterialColor primaryMaterialColor = getSwatch(const Color.fromARGB(255, 0, 0, 0));
  static MaterialColor primaryMaterialColorDark = getSwatch(const Color.fromARGB(255, 4, 6, 6));

  static const int secondaryColor = 0xff3544C4;

  static const Color grey100Color = Color(0xFFEEEEEE);
  static const Color grey200Color = Color(0xFFEEEEEE);
  static const Color grey300Color = Color(0xFFE0E0E0);
  static const Color grey400Color = Color(0xFFBDBDBD);
  static const Color grey500Color = Color(0xFF9E9E9E);
  static const Color grey600Color = Color(0xFF757575);
  static const Color grey700Color = Color(0xFF616161);
  static const Color grey800Color = Color(0xFF424242);
  static const Color grey900Color = Color(0xFF212121);

  static const Color red = Color(0xFFD50000);
  static const Color grey = Color.fromARGB(255, 123, 126, 130);
  static const Color yellow = Color.fromARGB(255, 255, 193, 7);
  static const Color peacockGreen = Color.fromARGB(255, 11, 116, 14);
  static const Color green = Color.fromARGB(255, 40, 167, 69);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color tranperent = Color.fromARGB(0, 0, 0, 0);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color purple = Color.fromARGB(255, 111, 66, 193);

  static const Color blue = Colors.blue;
  static const Color purpleDark = Color.fromARGB(255, 173, 36, 231);
  static const Color navyBlue = Color.fromARGB(255, 25, 61, 118);
  static const Color deepPurple = Colors.deepPurple;
  static const Color bg = Color.fromRGBO(236, 245, 255, 1);


  static const Color kScaffoldBackgroundColor = Color(0xffd6e2ea);
  static Color kRedColor = Colors.red.shade50;
  static Color kWhiteColor = Colors.white;
  static Color kBlackColor = Colors.black;

  static Color silver = const Color(0xFFC0C0C0);
  static Color youtubeBg = const Color.fromARGB(255, 240, 240, 240);


}
