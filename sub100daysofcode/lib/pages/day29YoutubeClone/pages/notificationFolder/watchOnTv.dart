import 'package:flutter/material.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/configs/config.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/constants/appcolors.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/utils/launcher_url.dart';

class Watchontv extends StatefulWidget {
  const Watchontv({super.key});

  @override
  State<Watchontv> createState() => _WatchontvState();
}

class _WatchontvState extends State<Watchontv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YoutubeAppColors.white,
      appBar: AppBar(
        title: const Text('Watch on TV',style: TextStyle(fontSize: 19),),
        backgroundColor: YoutubeAppColors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 105,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: YoutubeAppColors.red,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No TVs found. Make sure your TV is on and connected to Wi-Fi.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: YoutubeAppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 15,),
               Padding(
                padding:  const EdgeInsets.only(left: 25,right: 10),
                child: Column(children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'No TVs found',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: YoutubeAppColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Your TV needs to be on the same Wi-Fi network as your phone. You can also link your TV and phone using a TV code.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: YoutubeAppColors.grey700Color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                    onTap: (){
                      URL.launchUniversalLinkIOS(getHelp);
                    },
                    child: const Text('Get help',style: TextStyle(color: YoutubeAppColors.blue,fontSize: 16),),
                  )
                  ),
                ],),
                ),
             const SizedBox(height: 25,),
             const Divider(color: YoutubeAppColors.grey400Color,),
             const SizedBox(height: 10,),

             Padding(
                padding:  const EdgeInsets.only(left: 25,right: 10),
                child: Column(children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Link with TV code',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: YoutubeAppColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4,),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Another way of connecting devices. Learn how to get a code from your TV to enter here.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: YoutubeAppColors.grey700Color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                    onTap: (){
                    },
                    child: const Text('Enter TV code',style: TextStyle(color: YoutubeAppColors.blue,fontSize: 16),),
                  )
                  ),
                ],),
                ),
                const SizedBox(height: 25,),
                const Divider(color: YoutubeAppColors.grey400Color,),
                const SizedBox(height: 10,),

             Padding(
                padding:  const EdgeInsets.only(left: 25,right: 10),
                child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                    onTap: (){
                      URL.launchUniversalLinkIOS(cantfindyourTv);
                    },
                    child: const Text("Can't find your TV?",style: TextStyle(color: YoutubeAppColors.black,fontSize: 17),),
                  )
                  ),
                ],),
                ),
                const SizedBox(height: 13,),
                const Divider(color: YoutubeAppColors.grey400Color,),
            ],
          ),
        ),
      ),
    );
  }
}
