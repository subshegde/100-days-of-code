import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sub100daysofcode/constants/appColors.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/constants/appcolors.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/home/home.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/home/home2.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/shorts/pages/shorts.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/subscriptions/subscription.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/you/you.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeMainPage extends StatefulWidget {
  @override
  _HomeMainPageState createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage>
    with WidgetsBindingObserver {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey shortsKey = GlobalKey();
  final GlobalKey subscriptionKey = GlobalKey();
  final GlobalKey youKey = GlobalKey();
  bool _isTutorialShown = false;



    @override
  void initState() {
    super.initState();
      _checkTutorialStatus();
  }

  void safeSetState(VoidCallback fn){
    if(mounted){
      setState(() {
        fn();
      });
    }
  }

    Future<void> _checkTutorialStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isTutorialShown = prefs.getBool('isTutorialShown') ?? false;
    if (!_isTutorialShown) {
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
                "Your dashboard is your hub for tracking activity and accessing key features:\n\n"
                "Leaves: View your leave balance.\n"
                "Attendance: Check your attendance percentage.\n"
                "Reports: View detailed attendance reports.\n"
                "Logs: Track your check-in/out times.",
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
  identify: "Shorts",
  keyTarget: shortsKey,
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
                    Icons.access_time_rounded, 
                    size: 48,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Efficient Attendance Management",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "Track your attendance effortlessly. Check in, check out, and manage breaks seamlessly.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "After checking in, use 'Break In' and 'Break Out' for breaks.\n"
                "Complete any pending 'Break Out' before starting a new 'Break In'.\n"
                "Ensure all breaks are completed before checking out.",
                style: TextStyle(
                  fontSize: 14,
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
  identify: "Subscription",
  keyTarget: subscriptionKey,
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
                    Icons.calendar_today_rounded,
                    size: 48,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Manage Your Leaves Efficiently",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "Apply, update, or delete your leave requests. "
                "View your monthly leave status and track leave counts all in one place.",
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
  identify: "You",
  keyTarget: youKey,
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
                    Icons.payment_rounded,
                    size: 48,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Access Your Payslips Easily",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Easily download your payslip when it's generated. "
                "Keep track of your financial records effortlessly.",
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
 
    ];
  }

  Future<bool> _onWillPop(screenWidth) async {
    if (_currentIndex > 0) {
      safeSetSate(() {
        _currentIndex = 0;
      });
      _pageController.jumpToPage(0);
      return Future.value(false);
    } else {
      return await showModalBottomSheet(
          isDismissible: false,
          enableDrag: false,
          elevation: 2,
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 190,
                  color: YoutubeAppColors.white,
                  child: Column(
                    children: [
                      const ListTile(
                        title: Text(
                          'Are you sure want to exit YouTube ?',
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
                        ),
                        tileColor: YoutubeAppColors.purple,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: YoutubeAppColors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          width: screenWidth,
                          height: 40,
                          child: const Center(
                            child: Text(
                              'NO',
                              style: TextStyle(
                                  color: YoutubeAppColors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, true);
                          SystemNavigator.pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: YoutubeAppColors.black,
                                  style: BorderStyle.solid,
                                  strokeAlign: BorderSide.strokeAlignInside),
                              color: AppColors.tranperent,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6.0),
                                topRight: Radius.circular(6.0),
                                bottomLeft: Radius.circular(6.0),
                                bottomRight: Radius.circular(6.0),
                              )),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          width: screenWidth,
                          height: 40,
                          child: const Center(
                              child: Text(
                            'YES',
                            style:
                                TextStyle(color: YoutubeAppColors.black, fontSize: 16),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => _onWillPop(screenWidth),
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            safeSetSate(() {
              _currentIndex = index;
            });
          },
          children: const [
            HomeYoutube(),
            Shorts(),
            Subscription(),
            You(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            
            BottomNavigationBarItem(
              icon: _currentIndex == 0
                  ? Image.asset(
                      'assets/youtube/home.png',
                      height: 25,width: 25,key: homeKey,
                      color: YoutubeAppColors.blue,
                    )
                  : Image.asset(
                      'assets/youtube/home.png',
                      height: 20,width: 20,key: homeKey,
                      color: YoutubeAppColors.black,
                    ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 1
                  ? Image.asset(
                      'assets/youtube/shorts.png',
                      height: 25,width: 25,key: shortsKey,
                      color: YoutubeAppColors.blue,
                    )
                  : Image.asset(
                      'assets/youtube/shorts.png',
                      height: 20,width: 20,key: shortsKey,
                      color: YoutubeAppColors.black,
                    ),
              label: 'Shorts',
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 2
                  ? Image.asset(
                      'assets/youtube/crown.png',
                      height: 25,width: 25,key: subscriptionKey,
                      color: YoutubeAppColors.blue,
                    )
                  : Image.asset(
                      'assets/youtube/crown.png',
                      height: 20,width: 20,key: subscriptionKey,
                      color: YoutubeAppColors.black,
                    ),
              label: 'Subscription',
            ),
                            BottomNavigationBarItem(
                                  icon: _currentIndex == 3
                                      ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: YoutubeAppColors.blue, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/youtube/you/me.jpeg',
                            fit: BoxFit.cover,
                            width: 25,
                            height: 25,
                            key: youKey,
                          ),
                        ),
                      ),
                    )
                  : CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/youtube/you/me.jpeg',
                            fit: BoxFit.cover,
                            width: 25,
                            height: 25,
                            key: youKey,
                          ),
                        ),
                      ),
                  
              label: 'You',
            ),
          ],
          selectedLabelStyle: const TextStyle(fontSize: 13),
          selectedItemColor: YoutubeAppColors.blue,
          unselectedItemColor: YoutubeAppColors.grey,
          backgroundColor: YoutubeAppColors.white,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    safeSetSate(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void safeSetSate(VoidCallback fn) {
    if (mounted) {
      setState(() {
        fn();
      });
    }
  }
}
