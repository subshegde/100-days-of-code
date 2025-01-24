import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';

class TealAppBar {
  final String title;

  const TealAppBar({required this.title});

  AppBar build(BuildContext context) {
    return AppBar(
      foregroundColor: AppColors.white,
      backgroundColor: Colors.teal,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
