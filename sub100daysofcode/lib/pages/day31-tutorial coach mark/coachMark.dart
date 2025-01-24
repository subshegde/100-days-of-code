import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sub100daysofcode/constants/appColors.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';


class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey businessKey = GlobalKey();
  final GlobalKey schoolKey = GlobalKey();
  final GlobalKey settingsKey = GlobalKey();
  bool isTutorialShown = false;

  @override   
  void initState(){
    super.initState();

    checkTutorialStatus();
  }

    Future<void> checkTutorialStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isTutorialShown = prefs.getBool('isTutorialShown') ?? false;
    if (!isTutorialShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showTutorial());
    }
  }


void _showTutorial() {
  TutorialCoachMark(
    targets: _createTargets(),
    colorShadow: Colors.black,
    textSkip: "SKIP",
    textStyleSkip: const TextStyle(
      color: AppColors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    paddingFocus: 10,
    opacityShadow: 0.8,
    onSkip: () {
      _markTutorialAsShown();
      return true; 
    },
  ).show(context: context);

  Future.delayed(const Duration(seconds: 3), () {
    _markTutorialAsShown();
  });
}

Future<void> _markTutorialAsShown() async {
  final prefs = await SharedPreferences.getInstance();
  bool isTutorialShown = prefs.getBool('isTutorialShown') ?? false;

  if (!isTutorialShown) {
    await prefs.setBool('isTutorialShown', true);
  }
}

  List<TargetFocus> _createTargets() {
    return [
TargetFocus(
  identify: "Home",
  keyTarget: homeKey,
  alignSkip: Alignment.topRight,
  contents: [
    TargetContent(
      align: ContentAlign.top,
      builder: (context, controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.home_rounded,
                    size: 48,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 16),

               const Text(
                "Welcome !",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
               const Text(
                "Your dashboard is your hub for tracking activity and accessing key features:\n\n",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    controller.next();
                  },
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.blue,
                    size: 30,
                  ),
                  splashRadius: 24,
                  tooltip: "Next",
                ),
              ),
            ],
          ),
        );
      },
    ),
  ],
),
TargetFocus(
  identify: "Business",
  keyTarget: businessKey,
  alignSkip: Alignment.topRight,
  contents: [
    TargetContent(
      align: ContentAlign.top,
      builder: (context, controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E), 
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.business, 
                    size: 48,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Efficient Business Management",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "Track your business effortlessly. Businees related content goes here---",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.previous();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    splashRadius: 24, 
                    tooltip: "Previous",
                  ),

                  IconButton(
                    onPressed: () {
                      controller.next();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    splashRadius: 24,
                    tooltip: "Next",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  ],
),

TargetFocus(
  identify: "School",
  keyTarget: schoolKey,
  alignSkip: Alignment.topRight,
  contents: [
    TargetContent(
      align: ContentAlign.top,
      builder: (context, controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.school,
                    size: 48,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Manage Your School data Efficiently",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "Content related to this module goes here....",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.previous();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    splashRadius: 24,
                    tooltip: "Previous",
                  ),
                  IconButton(
                    onPressed: () {
                      controller.next();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    splashRadius: 24,
                    tooltip: "Next",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  ],
),
TargetFocus(
  identify: "Settings",
  keyTarget: settingsKey,
  alignSkip: Alignment.topRight,
  contents: [
    TargetContent(
      align: ContentAlign.top,
      builder: (context, controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.settings,
                    size: 48,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Handle your setting here!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Related to settings module content goes here....",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.previous();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    splashRadius: 24,
                    tooltip: "Previous",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  ],
),
 
    ];
  }




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tutorial Coach Mark',style: TextStyle(fontSize: 18),),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            key: homeKey,
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            key: businessKey,
            icon: const Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            key: schoolKey,
            icon: const Icon(Icons.school),
            label: 'School',
            backgroundColor: const Color.fromARGB(255, 239, 122, 161),
          ),
          BottomNavigationBarItem(
            key: settingsKey,
            icon: const Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: const Color.fromARGB(255, 140, 199, 247),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
