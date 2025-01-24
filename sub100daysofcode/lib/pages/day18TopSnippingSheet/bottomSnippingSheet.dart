import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:sub100daysofcode/constants/appColors.dart';
import 'package:sub100daysofcode/pages/day18TopSnippingSheet/shared/app_bar.dart';
import 'package:sub100daysofcode/pages/day18TopSnippingSheet/shared/default_grabbing.dart';
import 'package:sub100daysofcode/pages/day18TopSnippingSheet/shared/loginPage.dart';
import 'package:sub100daysofcode/pages/day18TopSnippingSheet/shared/splashScreen.dart';
import 'package:sub100daysofcode/pages/day18TopSnippingSheet/shared/dummy_content.dart';

class BottomSnippingSheet extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      SnappingSheet(
        lockOverflowDrag: true,
        snappingPositions: [
          SnappingPosition.factor(
            positionFactor: 0.0,
            grabbingContentOffset: GrabbingContentOffset.top,
          ),
          SnappingPosition.factor(
            snappingCurve: Curves.elasticOut,
            snappingDuration: Duration(milliseconds: 1750),
            positionFactor: 0.5,
          ),
          SnappingPosition.factor(positionFactor: 0.9),
        ],
        child: SplashScreen(),
        grabbingHeight: 40,
        grabbing: DefaultGrabbing(),
        sheetBelow: SnappingSheetContent(
          childScrollController: _scrollController,
          draggable: true,
          child: LoginPageSnippingBottom(
          ),
        ),
      ),)
    );
  }


}
