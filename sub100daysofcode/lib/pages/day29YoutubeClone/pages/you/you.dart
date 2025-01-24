import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/constants/appcolors.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/models/youtubeModel.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/notificationFolder/notifications.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/you/settings.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

class PlayListClass {
  String? url;
  String? header;
  String? content;

  PlayListClass({
    required this.url,
    required this.header,
    required this.content,
  });
}

class You extends StatefulWidget {
  const You({super.key});

  @override
  State<You> createState() => _YouState();
}

class _YouState extends State<You> {
  bool _isLoading = false;
  List<Data>? youtubeData;
  List<PlayListClass> playLists = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override 
  void initState(){
    super.initState();

    search('yakshagana');
    addPlayListData();
  }

  void addPlayListData() {
    playLists.add(PlayListClass(url: 'flutter.jpg', header: 'Liked videos', content: 'Private'));
    playLists.add(PlayListClass(url: 'water-falls.jpeg', header: 'Water Falls ❤️', content: 'Publi * Playlist'));
    playLists.add(PlayListClass(url: 'tiger.jpeg', header: 'Animals 🐯', content: 'Publi * Playlist'));
    playLists.add(PlayListClass(url: 'yakshagana.jpg', header: 'Yakshagana ❤️\n''ಯಕ್ಷಗಾನ', content: 'Public * Playlist'));
    playLists.add(PlayListClass(url: 'r-native.png', header: 'React native Course', content: 'Programming with Mosh'));
    playLists.add(PlayListClass(url: 'kotlin.jpg', header: 'Kotlin Course', content: 'Cheesy Code * Playlist'));
    playLists.add(PlayListClass(url: 'kohli.jpg', header: 'Watch Later', content: 'Private'));
    setState(() {});
  }

  
  Future<void> search([String query = '']) async {
      if (query.isEmpty) return;
      setState(() {
        _isLoading = true;
      });
    final url = Uri.parse(
      'https://yt-api.p.rapidapi.com/search?query=$query',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-rapidapi-key': 'ec06247fd2mshe27f87049c5fef8p1ced56jsn2fe21f0a6890', // Your API key
          'x-rapidapi-host': 'yt-api.p.rapidapi.com', // Host name
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedBody = jsonDecode(response.body);
        YoutubeModel model = YoutubeModel.fromJson(parsedBody);
        youtubeData?.clear();
        setState(() {
          youtubeData = model.data?.take(5).toList() ?? [];
          _isLoading = false;
        });

        print('youtubeData$youtubeData');
      } else {
        setState(() {
        _isLoading = false;
      });
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error occurred: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: YoutubeAppColors.white,
      appBar: AppBar(backgroundColor: YoutubeAppColors.white,actions: [ 
        Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
            onTap: (){
              _showBottomSheet(context);
            },
            child: Image.asset(
            'assets/youtube/you/share-screen.png',
            height: 30,
          ),),
        ),
        Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
             onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Notifications()));
            },
            child: Image.asset(
            'assets/youtube/you/bell.png',
            height: 20,
          ),),
        ),
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Image.asset(
            'assets/youtube/you/search-interface-symbol.png',
            height: 20,
          ),
        ),
        Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Settings()));
            },
            child: Image.asset(
            'assets/youtube/you/settings.png',
            height: 20,
          ),),
        ),],),
      
    body: SafeArea(child: SingleChildScrollView( 
        scrollDirection: Axis.vertical,
        child:
       
        Column( 
          children: [ 
        Padding(
         padding: const EdgeInsets.all(10.0),
          child:Column(children:
           [  Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [ 
             Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: YoutubeAppColors.white,
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  'assets/youtube/you/me.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(15),
              child: 
            Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                const Text('Subrahmanya S Hegde',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                Row(children: [ 
                  const Text('@SSHegde.Visuals',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: YoutubeAppColors.grey800Color),),
                  const SizedBox(width: 8,),
                  const Text('*',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800,color: YoutubeAppColors.grey600Color),),
                  const SizedBox(width: 8,),
                  const Text('View Channel',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w800,color: YoutubeAppColors.grey600Color),),
                  const SizedBox(width: 2,),
                  Image.asset('assets/youtube/you/next.png',height: 15,width: 15,)
                ],)
              ],
            ),)
            ],
          ),
          const SizedBox(height: 15,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:  Row(children: [ 
              Container(
                width: 130,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: YoutubeAppColors.lightGreyBox
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [ 
                    Image.asset(
                    'assets/youtube/you/switch-account.png',color: YoutubeAppColors.black,height: 20,width: 20,           
                  ),const SizedBox(width: 3,),
                  const Text('Switch account',style: TextStyle(color: YoutubeAppColors.black,fontSize: 12,fontWeight: FontWeight.bold),)
                  ],),
                )
              ),
              const SizedBox(width: 8,),
              Container(
                width: 130,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: YoutubeAppColors.lightGreyBox
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [ 
                    Image.asset(
                    'assets/youtube/you/google.png',color: YoutubeAppColors.black,height: 20,width: 20,           
                  ),const SizedBox(width: 3,),
                  const Text('Google account',style: TextStyle(color: YoutubeAppColors.black,fontSize: 12,fontWeight: FontWeight.bold),)
                  ],),
                )
              ),

              const SizedBox(width: 8,),
              Container(
                width: 140,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: YoutubeAppColors.lightGreyBox,
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [ 
                    Image.asset(
                    'assets/youtube/you/incognito.png',color: YoutubeAppColors.black,height: 20,width: 20,           
                  ),const SizedBox(width: 3,),
                  const Text('Turn on Incognito',style: TextStyle(color: YoutubeAppColors.black,fontSize: 12,fontWeight: FontWeight.bold),)
                  ],),
                )
              ),
              const SizedBox(width: 8,),
               Container(
                width: 130,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: YoutubeAppColors.lightGreyBox,
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [ 
                    Image.asset(
                    'assets/youtube/you/share.png',color: YoutubeAppColors.black,height: 20,width: 20,           
                  ),const SizedBox(width: 3,),
                  const Text('Share Channel',style: TextStyle(color: YoutubeAppColors.black,fontSize: 12,fontWeight: FontWeight.bold),)
                  ],),
                )
              ),
          ],)
          ,),
         
          const SizedBox(height: 17,),
          Padding(
            padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ 
              Container(child: const Text('History',style: TextStyle(fontSize: 18,color: YoutubeAppColors.black,fontWeight: FontWeight.bold),),),
              Container(
                height: 33,
                width: 75,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: YoutubeAppColors.white,border: Border.all(color: YoutubeAppColors.grey500Color,width: 1)),
                child: const Center(child: Text('View All',style: TextStyle(fontSize: 13,color: YoutubeAppColors.black,fontWeight: FontWeight.w500),)),)
            ],),
          ),]
          )
          ),
        _horizontalListView(youtubeData??[]),
         
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ 
              Container(child: const Text('Playlists',style: TextStyle(fontSize: 18,color: YoutubeAppColors.black,fontWeight: FontWeight.bold),),),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [ 
                Image.asset('assets/youtube/you/plus.png',scale: 28,),
                const SizedBox(width: 12,),
                Container(
                height: 33,
                width: 80,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: YoutubeAppColors.white,border: Border.all(color: YoutubeAppColors.grey500Color,width: 1)),
                child: const Center(child: Text('View All',style: TextStyle(fontSize: 13,color: YoutubeAppColors.black,fontWeight: FontWeight.w500),)),),
              ],)
            ],),
          ),

          playListsWidgets(playLists??[]),

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
                      'assets/youtube/you/play.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Your videos',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
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
                      'assets/youtube/you/download.png',color: YoutubeAppColors.black,height: 25,width: 25,           
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
                      'assets/youtube/you/learning.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Your courses',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/you/clapperboard.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Your movies',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
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
                      'assets/youtube/you/youtube-you.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Get YouTube Premium',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                      Image.asset(
                      'assets/youtube/you/bar-chart.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Time watched',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
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
                      'assets/youtube/you/question.png',color: YoutubeAppColors.black,height: 25,width: 25,           
                    ),const SizedBox(width: 20,),
                    const Text('Help and feedback',style: TextStyle(color: YoutubeAppColors.black,fontSize: 15,fontWeight: FontWeight.w400),)
                    ],),
                  ),
                 
            ],),
          ),
          ],
          
      ),
               

       )
       ,)
    );    
    
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



Widget playListsWidgets(List<PlayListClass> data) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          _isLoading ? 5 : data.length,
          (index) {
            if (_isLoading) {
              return _buildSkeletonLoader();
            } else {
              var playlist = data[index];
              return ItemCard(
                title: playlist.content,
                header: playlist.header,
                url: playlist.url,
              );
            }
          },
        ),
      ),
    );
  }


Widget _horizontalListView(List<Data> data) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
        _isLoading ? 5 : data.length,
        (index) {
          if (_isLoading) {
            return _buildSkeletonLoader();
          } else {
            final item = data[index];

            final YoutubePlayerController _controller = YoutubePlayerController(
              initialVideoId: item.videoId ?? 'default_video_id',
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            );

            return Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.only(left: 5.0),
              height: 130,
              width: 150,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: 
                       YoutubePlayer(
                        progressColors: const ProgressBarColors(backgroundColor: YoutubeAppColors.grey, playedColor: YoutubeAppColors.red),
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.red,
                        bottomActions: [
                          CurrentPosition(),
                          ProgressBar(isExpanded: true),
                          RemainingDuration(

                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Flexible(
                      child: Text(
                        item.title ?? "Untitled Video",
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 0),
                    Flexible(
                      child: Text(
                        item.description ?? "No description available.",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12.0,
                          height: 1.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    ),
  );
}

Widget _buildSkeletonLoader() {
  return Container(
    padding: const EdgeInsets.all(5.0),
    margin: const EdgeInsets.only(left: 5.0,right: 5),
    height: 150,
    width: 150,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 80,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 2),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 10,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 1,
              width: 100,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
}


class ItemCard extends StatefulWidget {
  final String? url;
  final String? header;
  final String? title;

  ItemCard({
    required this.title,
    required this.header,
    required this.url,
  });

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {

@override
Widget build(BuildContext context) {
  return Stack(
    children: [

      Positioned(
        top:-2,
        left: 10,
        child: Container(
          decoration: BoxDecoration(color: const Color.fromARGB(255, 211, 211, 211),borderRadius: BorderRadius.circular(10)),
          height: 37,
          width: 140,
        )),
      Positioned(
        top: 2,
        left: 10,
        child: Container(
          decoration: BoxDecoration(color: const Color.fromARGB(255, 185, 184, 184),borderRadius: BorderRadius.circular(8)),
          height: 37,
          width: 140,
        )),

    Container(
    padding: const EdgeInsets.all(0),
    margin: const EdgeInsets.only(left: 5.0),
    height: 140,
    width: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/youtube/you/${widget.url}',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 2),
          
          Flexible(
            child: Text(
              widget.header ?? "Untitled Video",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 0),
          
          Flexible(
            child: Text(
              widget.title ?? "No description available.",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12.0,
                height: 1.5,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    ),
  )],);
}

}