import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_action/slide_action.dart';

class SlideToPerformExample extends StatefulWidget {
  const SlideToPerformExample({Key? key}) : super(key: key);

  @override
  State<SlideToPerformExample> createState() => _SlideToPerformExampleState();
}

class _SlideToPerformExampleState extends State<SlideToPerformExample> {
  late final ScrollController _scrollController;
  bool _isLoading = false; // To manage loading state
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
     _controllerCenter =
        ConfettiController(duration: const Duration(microseconds: 1));
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controllerCenter.dispose();
    super.dispose();
  }

  Future<void> _performApiCall() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isLoading = false;
    });
    _controllerCenter.play();
    _showGreetingDialog();
  }

  Future<void> _showGreetingDialog() async {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Hey there"),
        content: const Text("Successfully Completed!"),
        actions: [
          CupertinoDialogAction(
            child: const Text("Wave back!"),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slide Action'),backgroundColor: Colors.teal,foregroundColor: Colors.white,),
      body: SafeArea(
        child: Column(
          children: [
            buildSwipper(context),
            ConfettiWidget(
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
          ],
        ),
      ),
    );
  }

  Widget buildSwipper(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AsyncExample(
        callback: _performApiCall,
        isLoading: _isLoading,
      ),
    );
  }
}

class AsyncExample extends StatelessWidget {
  const AsyncExample({
    this.callback,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);

  final FutureOr<void> Function()? callback;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      stretchThumb: true,
      trackBuilder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              // "Thumb fraction: ${state.thumbFractionalPosition.toStringAsPrecision(2)}",
              "Slide action",
            ),
          ),
        );
      },
      thumbBuilder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: state.isPerformingAction ? Colors.grey : Colors.black,
            borderRadius: BorderRadius.circular(100),
          ),
          child: state.isPerformingAction
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
        );
      },
      action: callback,
    );
  }
}
