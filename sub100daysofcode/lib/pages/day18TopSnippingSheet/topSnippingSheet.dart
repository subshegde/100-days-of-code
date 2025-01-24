import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:sub100daysofcode/pages/day18TopSnippingSheet/shared/app_bar.dart';
import 'package:sub100daysofcode/pages/day18TopSnippingSheet/shared/default_grabbing.dart';
import 'package:sub100daysofcode/pages/day18TopSnippingSheet/shared/dummy_background.dart';
import 'package:sub100daysofcode/pages/day18TopSnippingSheet/shared/dummy_content.dart';

class AbovePage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TealAppBar(title: "Snapping Sheet Top").build(context),
      body: SafeArea(child: SnappingSheet(
        lockOverflowDrag: true,
        snappingPositions: [
          SnappingPosition.factor(
            grabbingContentOffset: GrabbingContentOffset.bottom,
            positionFactor: 1.0,
          ),
          SnappingPosition.factor(
            snappingCurve: Curves.elasticOut,
            snappingDuration: Duration(milliseconds: 1750),
            positionFactor: 0.5,
          ),
          SnappingPosition.factor(
            positionFactor: 0.1,
            grabbingContentOffset: GrabbingContentOffset.top,
          ),
        ],
        child: DummyBackgroundContent(),
        grabbingHeight: 50,
        grabbing: DefaultGrabbing(
          color:Colors.black,
          reverse: true,
        ),
        sheetAbove: SnappingSheetContent(
          childScrollController: _scrollController,
          draggable: true,
          child: DummyContent(
            reverse: true,
            controller: _scrollController,
          ),
        ),
      ),)
    );
  }
}
