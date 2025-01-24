import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/configs/config.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/constants/appcolors.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/utils/launcher_url.dart';

class HelpandFeedback extends StatefulWidget {
  const HelpandFeedback({super.key});

  @override
  State<HelpandFeedback> createState() => _HelpandFeedbackState();
}

class _HelpandFeedbackState extends State<HelpandFeedback> {

  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YoutubeAppColors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showMenu(context);
            },
          ),
        ],
        title: const Text('Help',style: TextStyle(fontSize: 19),),
        backgroundColor: YoutubeAppColors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              const SizedBox(height: 15,),
               Padding(
                padding:  const EdgeInsets.only(left: 25,right: 10),
                child: Column(children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Popular help resources',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: YoutubeAppColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                   Align(
                    alignment: Alignment.topLeft,
                    child: Row(children: [
                      Image.asset('assets/youtube/notifications/list.png',scale: 2.5,),
                      const SizedBox(width: 6,),
                      const Text('How to earn money on YouTube',style: TextStyle(fontSize: 13.5),),
                    ],)
                  ),
                  const SizedBox(height: 15,),
                   Align(
                    alignment: Alignment.topLeft,
                    child: Row(children: [
                      Image.asset('assets/youtube/notifications/list.png',scale: 2.5,),
                      const SizedBox(width: 6,),
                      const Text('Change video privacy settings',style: TextStyle(fontSize: 13.5),),
                    ],)
                  ),
                  const SizedBox(height: 15,),
                   Align(
                    alignment: Alignment.topLeft,
                    child: Row(children: [
                      Image.asset('assets/youtube/notifications/list.png',scale: 2.5,),
                      const SizedBox(width: 6,),
                      const Text('Manage channel settings',style: TextStyle(fontSize: 13.5),),
                    ],)
                  ),
                  const SizedBox(height: 15,),
                   Align(
                    alignment: Alignment.topLeft,
                    child: Row(children: [
                      Image.asset('assets/youtube/notifications/list.png',scale: 2.5,),
                      const SizedBox(width: 6,),
                      const Text('Change language or location settings',style: TextStyle(fontSize: 13.5),),
                    ],)
                  ),
                  const SizedBox(height: 15,),
                   Align(
                    alignment: Alignment.topLeft,
                    child: Row(children: [
                      Image.asset('assets/youtube/notifications/list.png',scale: 2.5,),
                      const SizedBox(width: 6,),
                      const Text("Manage your YouTube channel's basic info",style: TextStyle(fontSize: 13.5),),
                    ],)
                  ),

                ],),
                ),
                const SizedBox(height: 15,),
                  Container(
                    margin: const EdgeInsets.only(left: 10,right: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: 
                      TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(icon: const Icon(Icons.search),onPressed: (){},),
                          fillColor: const Color.fromARGB(255, 216, 238, 255),
                          filled: true,
                          hintText: 'Search help',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: .26,
                                        spreadRadius: 1.5,
                                        color: Colors.black.withOpacity(.05),
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.mic, size: 20),
                                    onPressed: () {
                                    },
                                  ),
                                ),
                                if(_searchController.text.isNotEmpty)...[
                                IconButton(
                                    icon: const Icon(Icons.clear, size: 20),
                                    onPressed: () {
                                    },
                                  ),],
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        ),
                      )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  const Divider(color: YoutubeAppColors.grey400Color,),

                  Padding(
                padding:  const EdgeInsets.only(left: 25,right: 10),
                child: Column(children: [
                  const SizedBox(height: 4,),
                    Align(
                    alignment: Alignment.topLeft,
                    child: Row(children: [
                      Image.asset('assets/youtube/notifications/msg.png',scale: 2.5,),
                      const SizedBox(width: 6,),
                      const Text('Send feedback',style: TextStyle(fontSize: 13.5),),
                    ],)
                  ),])),

                  const SizedBox(height: 05,),
                  const Divider(color: YoutubeAppColors.grey400Color,),

            ],
          ),
        ),
      ),
    );
  }

Future<void> _showGreetingDialog() async {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            "YouTube",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/youtube/notifications/youtube.png',
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 10),
              const Text("Version 1.0.0"),
            ],
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text("@SSHegde.Visuals",style: TextStyle(fontSize: 10),),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ],
    ),
  );
}



  
void _showMenu(BuildContext context) {
  showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(200, 0, 0, 0),
    items: [
      const PopupMenuItem<String>(
        value: 'option1',
        child: Row(
          children: [
            Text('View in Google Play Store'),
          ],
        ),
      ),
      const PopupMenuItem<String>(
        value: 'option2',
        child: Row(
          children: [
            Text('Clear Help History'),
          ],
        ),
      ),
      const PopupMenuItem<String>(
        value: 'option3',
        child: Row(
          children: [
            Text('Version info'),
          ],
        ),
      ),
      
    ],
    elevation: 8.0,
  ).then((value) {
    if (value != null) {
      switch (value) {
        case 'option1':
        URL.launchUniversalLinkIOS(youTubePlayStore);
          break;
        case 'option2':
          break;
        case 'option3':
        _showGreetingDialog();
          break;
      }
    }
  });
}
}