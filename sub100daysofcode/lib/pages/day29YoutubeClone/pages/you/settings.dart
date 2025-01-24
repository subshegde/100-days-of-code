import 'package:flutter/material.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/constants/appcolors.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YoutubeAppColors.white,
      appBar: AppBar(title: const Text('Settinngs',style: TextStyle(color: YoutubeAppColors.black),),centerTitle: true,backgroundColor: YoutubeAppColors.white,),
      body: SafeArea(child: 
      SingleChildScrollView( child: Column(children: [ 
          Container(
            margin: const EdgeInsets.only(left: 7),
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [ 
              Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/general.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('General',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/switch-account.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Switch account',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                   const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/family.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Family Centre',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/bell-settings.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Notifications',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/tag.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Purchases and memberships',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                   const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/billing.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Billing and payments',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),


                const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/manage-all-history.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Manage all history',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                   const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/your-data-in-youtube.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Your data in YouTube',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                 const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/privacy.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Privacy',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/connected-apps.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Connected apps',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                   const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/try-experiment.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Try experimental new features',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  )
            ],),
          ),

          const Divider(color: YoutubeAppColors.grey400Color,),

            Container(
            margin: const EdgeInsets.only(left: 7),
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [ 
               Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                     
                     Text('Video and audio preferences',style: TextStyle(color: YoutubeAppColors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                    ],),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/hd.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Video quality preferences',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/play-button.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Playback',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/cc.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Captions',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                   const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/save-instagram.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Data savings',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),


                const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/download.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Downloads',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                   const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/chat.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Live chat',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                 const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/accessibility.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Accessibility',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/monitor.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Watch on TV',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),

      ],

      ),
      ),
      

          const Divider(color: YoutubeAppColors.grey400Color,),

            Container(
            margin: const EdgeInsets.only(left: 7),
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [ 
               Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                     
                     Text('Help and policy',style: TextStyle(color: YoutubeAppColors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                    ],),
                  ),
                  const SizedBox(height: 10,),
              Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/help.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Help',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/new-document.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('YouTube Terms of Service',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                   const SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/reply-message.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Send feedback',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/settings/info.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('About',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
               
            ],),
          ),
          const Divider(color: YoutubeAppColors.grey400Color,),

            Container(
            margin: const EdgeInsets.only(left: 7),
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [ 
               Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4.0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                     
                     Text('Developer preferences',style: TextStyle(color: YoutubeAppColors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                    ],),
                  ),
                const SizedBox(height: 10,),
               
            ],),
          ),

      ]
      ),

   
   
   
   
   
    )));
  }
}