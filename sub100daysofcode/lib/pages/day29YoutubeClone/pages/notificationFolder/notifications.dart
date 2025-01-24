import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/configs/config.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/constants/appcolors.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/notificationFolder/helpAndFeedback.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/utils/launcher_url.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/notificationFolder/watchOnTv.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/you/settings.dart';

class AllNotificationsClass {
  String? imaageUrl;
  String? channelLogo;
  String? header;
  String? time;
  String? when;
  bool? seen;
  bool? isMentioned;

  AllNotificationsClass({
    required this.imaageUrl,
    required this.header,
    required this.time,
    required this.channelLogo,
    required this.when,
    required this.seen,
    required this.isMentioned,
  });
}

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool _isLoading = false;
  List<AllNotificationsClass> allNotificationsClass = [];
  List<AllNotificationsClass> mentionedNotificationsClass = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool all = true;
  bool mentions = false;

  @override 
  void initState(){
    super.initState();

      addNotificationsData();
    
  }

  Future<void> delayExample() async {
  await Future.delayed(const Duration(seconds: 3));
}
  void addNotificationsData() {
    allNotificationsClass.add(AllNotificationsClass(isMentioned:false,seen: true,imaageUrl: 'test-match.png', header: 'Test-Match IND VS AUS', time: '1 day ago',when: 'This week',channelLogo: ''));
    allNotificationsClass.add(AllNotificationsClass(isMentioned:false,seen:false,imaageUrl: 'uday-kadbal.jpg', header: 'Recommended: Yakshagana | Uday Kadbal', time: '1 day ago',when: 'This week',channelLogo: ''));
    allNotificationsClass.add(AllNotificationsClass(isMentioned:false,seen:false,imaageUrl: 'kgf-3.jpg', header: 'Recommended: KGF Chapter-3 Teaser-2025', time: '2 weeks ago',when: 'Older',channelLogo: 'Older'));
    allNotificationsClass.add(AllNotificationsClass(isMentioned:false,seen:false,imaageUrl: 'push-notifications.png', header: 'Recommended: Flutter push notigicatios', time: '2 weeks ago',when: 'Older',channelLogo: ''));
    allNotificationsClass.add(AllNotificationsClass(isMentioned:false,seen:false,imaageUrl: 'bloc.png', header: 'Recommended: Flutter Bloc', time: '2 weeks ago',when: 'Older',channelLogo: ''));
    allNotificationsClass.add(AllNotificationsClass(isMentioned:false,seen:false,imaageUrl: 'udupi.jpg', header: 'Recommended: Udupi', time: '2 weeks ago',when: 'Older',channelLogo: ''));
    allNotificationsClass.add(AllNotificationsClass(isMentioned:false,seen:false,imaageUrl: 'ui.jpg', header: 'Recommended: UI teaser-2025', time: '2 weeks ago',when: 'Older',channelLogo: ''));
    allNotificationsClass.add(AllNotificationsClass(isMentioned:false,seen:false,imaageUrl: 'bigg-boss-kicha.jpg', header: 'Recommended: Bigboss Kicha Sudeep', time: '2 weeks ago',when: 'Older',channelLogo: ''));
    allNotificationsClass.add(AllNotificationsClass(isMentioned:false,seen:false,imaageUrl: 'kp.jpg', header: 'Recommended: Solo Trip-KP', time: '2 weeks ago',when: 'Older',channelLogo: ''));
    allNotificationsClass.add(AllNotificationsClass(isMentioned:false,seen:false,imaageUrl: 'max.jpg', header: 'Recommended: MAX teaser-2025', time: '2 weeks ago',when: 'Older',channelLogo: ''));
    
    mentionedNotificationsClass = allNotificationsClass.where((notification) => notification.isMentioned!).toList();
    setState(() {});
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    key: _scaffoldKey,
    backgroundColor: YoutubeAppColors.white,
    appBar: AppBar(
      title: const Text('Notifications'),
      backgroundColor: YoutubeAppColors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
            onTap: () {
              _showBottomSheet(context);
            },
            child: Image.asset(
              'assets/youtube/notifications/share-screen.png',
              height: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Image.asset(
            'assets/youtube/notifications/search-interface-symbol.png',
            height: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
            onTap: () {
              _showMenu(context);
            },
            child: Image.asset(
              'assets/youtube/notifications/dots.png',
              height: 20,
            ),
          ),
        ),
      ],
    ),
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 18),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        all = true;
                        mentions = false;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 33,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: all ? YoutubeAppColors.black : YoutubeAppColors.lightGreyBox,
                      ),
                      child: Center(
                        child: Text(
                          'All',
                          style: TextStyle(
                            color: all ? YoutubeAppColors.white : YoutubeAppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        all = false;
                        mentions = true;
                      });
                    },
                    child: Container(
                      width: 90,
                      height: 33,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: mentions ? YoutubeAppColors.black : YoutubeAppColors.lightGreyBox,
                      ),
                      child: Center(
                        child: Text(
                          'Mentions',
                          style: TextStyle(
                            color: mentions ? YoutubeAppColors.white : YoutubeAppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    notificationsWidgets(
                      mentions ? mentionedNotificationsClass : allNotificationsClass,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
            Text('Settings'),
          ],
        ),
      ),
      const PopupMenuItem<String>(
        value: 'option2',
        child: Row(
          children: [
            Text('Watch on TV'),
          ],
        ),
      ),
      const PopupMenuItem<String>(
        value: 'option3',
        child: Row(
          children: [
            Text('Terms and privacy policy'),
          ],
        ),
      ),
      const PopupMenuItem<String>(
        value: 'option4',
        child: Row(
          children: [
            Text('Help and feedback'),
          ],
        ),
      ),
    ],
    elevation: 8.0,
  ).then((value) {
    if (value != null) {
      switch (value) {
        case 'option1':
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Settings()));
          break;
        case 'option2':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Watchontv()));
          break;
        case 'option3':
        URL.launchUniversalLinkIOS(termsAndPrivacyPolicy);
          break;
        case 'option4':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const HelpandFeedback()));
          break;
      }
    }
  });
}


void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: 180,
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
                      color: YoutubeAppColors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Select a device',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              
              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/youtube/you/monitor.png', 
                      color: YoutubeAppColors.black, 
                      height: 25, 
                      width: 25,
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Link with  TV code',
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
                      'assets/youtube/you/info.png', 
                      color: YoutubeAppColors.black, 
                      height: 25, 
                      width: 25,
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Learn more',
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



Widget notificationsWidgets(List<AllNotificationsClass> data) {
  return data.isNotEmpty ? ListView.builder(
    itemCount: data.length,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      var notfications = data[index];
      return ItemCard(
        title: notfications.time,
        header: notfications.header,
        url: notfications.imaageUrl,
        seen: notfications.seen,
      );
    },
  ):Center(
    child: Column(
      children: [
        const SizedBox(height: 130,),
        Container(
          child: Image.asset('assets/youtube/notifications/no-mentions.png',scale: 2,color: const Color.fromARGB(255, 215, 215, 215),),
        ),
        const SizedBox(height: 40,),
        const Text('No mentions yet',style: TextStyle(color: YoutubeAppColors.grey,fontSize: 17),)
      ],
    ),
  );
}}


class ItemCard extends StatefulWidget {
  final String? url;
  final String? header;
  final String? title;
  final bool? seen;

  ItemCard({
    required this.title,
    required this.header,
    required this.url,
    required this.seen,
  });

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {

@override
Widget build(BuildContext context) {
  return 
  Container(
  padding: const EdgeInsets.only(left:0,right: 0),
  margin: const EdgeInsets.only(left: 5.0),
  height: 140,
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
  ),
  child: Padding(
    padding: const EdgeInsets.all(0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(widget.seen == false)...[
            Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(color: YoutubeAppColors.blue,borderRadius: BorderRadius.circular(30)),
              margin: const EdgeInsets.only(top: 18,right: 4),
               ),]else if(widget.seen == true)...[
                Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(color: YoutubeAppColors.white,borderRadius: BorderRadius.circular(30)),
              margin: const EdgeInsets.only(top: 18,right: 4),),
               ],
             Container(
              margin: const EdgeInsets.only(top: 3,right: 4,left: 4),
               child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/youtube/notifications/${widget.url}',
                  fit: BoxFit.cover,
                  height: 35,
                  width: 35,
                ),
                           ),
             ),
            Expanded(child: 
            Container(
              width: 160,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.header ?? "Untitled Video",
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.title ?? "No description available.",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12.0,
                        height: 1.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
            ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/youtube/notifications/${widget.url}',
                fit: BoxFit.cover,
                height: 75,
                width: 130,
              ),
            ),
            GestureDetector(
              onTap: (){

              },
              child: Image.asset('assets/youtube/notifications/more.png',scale: 25,),)

          ],
        ),
      ],
    ),
  ),
);
}

}