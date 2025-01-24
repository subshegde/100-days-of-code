
import 'package:flutter/material.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/constants/appcolors.dart';

class Sheets{

  
static void showBottomMainSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: 400,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: YoutubeAppColors.grey400Color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/youtube/shorts/left.png', 
                      color: YoutubeAppColors.black, 
                      height: 25, 
                      width: 25,
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Description',
                      style: TextStyle(
                        color: YoutubeAppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/youtube/shorts/save-instagram.png', 
                      color: YoutubeAppColors.black, 
                      height: 25, 
                      width: 25,
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Save to playlist',
                      style: TextStyle(
                        color: YoutubeAppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/youtube/shorts/cc.png', 
                      color: YoutubeAppColors.black, 
                      height: 25, 
                      width: 25,
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Captions',
                      style: TextStyle(
                        color: YoutubeAppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/youtube/shorts/general.png', 
                      color: YoutubeAppColors.black, 
                      height: 25, 
                      width: 25,
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Quality',
                      style: TextStyle(
                        color: YoutubeAppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/youtube/shorts/stop.png', 
                      color: YoutubeAppColors.black, 
                      height: 25, 
                      width: 25,
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Not interested',
                      style: TextStyle(
                        color: YoutubeAppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
                            const SizedBox(height: 10),

              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/youtube/shorts/error.png', 
                      color: YoutubeAppColors.black, 
                      height: 25, 
                      width: 25,
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      "Don't recommend this channel",
                      style: TextStyle(
                        color: YoutubeAppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/youtube/shorts/red-flag.png', 
                      color: YoutubeAppColors.black, 
                      height: 25, 
                      width: 25,
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Report',
                      style: TextStyle(
                        color: YoutubeAppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
                            const SizedBox(height: 10),

              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/youtube/shorts/information.png', 
                      color: YoutubeAppColors.black, 
                      height: 25, 
                      width: 25,
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Send feedback',
                      style: TextStyle(
                        color: YoutubeAppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}




static void showBottomShareSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: 250,
        color: Colors.white,
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: YoutubeAppColors.grey400Color,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0,bottom: 8.0,right: 8.0),
                  child: Row(children: [ 
                  Container(child:
                   Column(children: [
                    Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 15, 
                      child: ClipOval(
                        child: Image.asset(
                          'assets/youtube/shorts/whatsapp.png',
                          fit: BoxFit.cover,
                          width: 50, 
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  const Text('WhatsApp',style: TextStyle(color: YoutubeAppColors.grey,fontSize: 10),)
                  ],),),
                  const SizedBox(width: 25,),
                  Container(child:
                   Column(children: [
                    Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 15, 
                      child: ClipOval(
                        child: Image.asset(
                          'assets/youtube/shorts/instagram.png',
                          fit: BoxFit.cover,
                          width: 50, 
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  const Text('Instagram',style: TextStyle(color: YoutubeAppColors.grey,fontSize: 10),)
                  ],),),
                  const SizedBox(width: 25,),
                  Container(child:
                   Column(children: [
                    Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 15, 
                      child: ClipOval(
                        child: Image.asset(
                          'assets/youtube/shorts/telegram.png',
                          fit: BoxFit.cover,
                          width: 50, 
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  const Text('Telegram',style: TextStyle(color: YoutubeAppColors.grey,fontSize: 10),)
                  ],),),
                  const SizedBox(width: 25,),
                  Container(child:
                   Column(children: [
                    Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 15, 
                      child: ClipOval(
                        child: Image.asset(
                          'assets/youtube/shorts/gmail.png',
                          fit: BoxFit.cover,
                          width: 50, 
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  const Text('Gmail',style: TextStyle(color: YoutubeAppColors.grey,fontSize: 10),)
                  ],),),
                  const SizedBox(width: 25,),
                  Container(child:
                   Column(children: [
                    Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 15, 
                      child: ClipOval(
                        child: Image.asset(
                          'assets/youtube/shorts/chat.png',
                          fit: BoxFit.cover,
                          width: 50, 
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  const Text('Messages',style: TextStyle(color: YoutubeAppColors.grey,fontSize: 10),)
                  ],),),
                  const SizedBox(width: 25,),
                  Container(child:
                   Column(children: [
                    Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 15, 
                      child: ClipOval(
                        child: Image.asset(
                          'assets/youtube/shorts/twitter.png',
                          fit: BoxFit.cover,
                          width: 50, 
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  const Text('X',style: TextStyle(color: YoutubeAppColors.grey,fontSize: 10),)
                  ],),),
                  const SizedBox(width: 25,),
                  Container(child:
                   Column(children: [
                    Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 15, 
                      child: ClipOval(
                        child: Image.asset(
                          'assets/youtube/shorts/bluetooth.png',
                          fit: BoxFit.cover,
                          width: 50, 
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  const Text('Bluetooth',style: TextStyle(color: YoutubeAppColors.grey,fontSize: 10),)
                  ],),),
                  const SizedBox(width: 25,),
                  Container(child:
                   Column(children: [
                    Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 15, 
                      child: ClipOval(
                        child: Image.asset(
                          'assets/youtube/shorts/chat.png',
                          fit: BoxFit.cover,
                          width: 50, 
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  const Text('Messaging',style: TextStyle(color: YoutubeAppColors.grey,fontSize: 10),)
                  ],),),
                  const SizedBox(width: 25,),
                  Container(child:
                   Column(children: [
                    Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 15, 
                      child: ClipOval(
                        child: Image.asset(
                          'assets/youtube/shorts/more.png',
                          fit: BoxFit.cover,
                          width: 45, 
                          height: 45,
                        ),
                      ),
                    ),
                  ),
                  const Text('More',style: TextStyle(color: YoutubeAppColors.grey,fontSize: 10),)
                  ],),)
                                ],),
                ),),

        

              const Divider(color: YoutubeAppColors.grey300Color,),

              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 50,width: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: YoutubeAppColors.grey200Color),
                      child:   Image.asset(
                      'assets/youtube/shorts/copy-link.png', 
                      color: const Color.fromARGB(255, 53, 52, 52), 
                      height: 20, 
                      width: 20,
                    ),),
                    const SizedBox(width: 20),
                    const Text(
                      'Copy Link',
                      style: TextStyle(
                        color: YoutubeAppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 50,width: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: YoutubeAppColors.grey200Color),
                      child:   Image.asset(
                      'assets/youtube/shorts/collaboration.png', 
                      color: const Color.fromARGB(255, 53, 52, 52), 
                      height: 20, 
                      width: 20,
                    ),),
                    const SizedBox(width: 20),
                    const Text(
                      'Quick Share',
                      style: TextStyle(
                        color: YoutubeAppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
             
            ],
          ),
        
      );
    },
  );
}

}
