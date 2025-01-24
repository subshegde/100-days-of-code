import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  LoadingOverlay({required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          const Opacity(
            opacity: 0.5,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(
              color: kSecondaryColor,
            ),
          ),
      ],
    );
  }
}