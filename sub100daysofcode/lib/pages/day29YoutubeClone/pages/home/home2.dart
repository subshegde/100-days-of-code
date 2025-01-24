import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:sub100daysofcode/constants/appColors.dart';
import 'package:http/http.dart' as http;
import 'package:sub100daysofcode/pages/day29YoutubeClone/constants/appcolors.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/models/youtubeModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeYoutube extends StatefulWidget {
  const HomeYoutube({Key? key}) : super(key: key);

  @override
  _HomeYoutubeState createState() => _HomeYoutubeState();
}

class _HomeYoutubeState extends State<HomeYoutube> {
  int selectedItemIndex = 0;
  
  bool _hasSpeech = false;
  bool _logEvents = false;
  bool _onDevice = false;
  final TextEditingController _pauseForController = TextEditingController(text: '3');
  final TextEditingController _listenForController = TextEditingController(text: '30');
  final TextEditingController _searchController = TextEditingController();
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  bool _isLoading = false;

  bool all = true;
  bool yakshagana = false;
  bool flutter = false;
  bool music = false;
  bool live = false;
  bool computerProgramming = false;

  final List<Map<String, String>> items = [
    {'image': 'assets/youtube/home/trending-topic.png', 'text': 'Trending'},
    {'image': 'assets/youtube/home/bag.png', 'text': 'Shopping'},
    {'image': 'assets/youtube/home/musical-note.png', 'text': 'Music'},
    {'image': 'assets/youtube/home/clapperboard.png', 'text': 'Films'},
    {'image': 'assets/youtube/home/live.png', 'text': 'Live'},
    {'image': 'assets/youtube/home/console.png', 'text': 'Gaming'},
    {'image': 'assets/youtube/home/newspaper-folded.png', 'text': 'News'},
    {'image':'assets/youtube/home/trophy.png', 'text': 'Sport'},
    {'image': 'assets/youtube/home/learning.png', 'text': 'Courses'},
    {'image': 'assets/youtube/home/make-up.png', 'text': 'Fashion & beauty'},
    {'image': 'assets/youtube/home/podcast.png', 'text': 'Podcasts'},
    {'image': 'assets/youtube/home/youtube-premium.png', 'text': 'YouTube Premium'},
    {'image': 'assets/youtube/home/yt.png', 'text': 'YouTube Studio'},
    {'image': 'assets/youtube/home/ym.png', 'text': 'YouTube Music'},
    {'image': 'assets/youtube/home/yk.png', 'text': 'YouTube Kids'},
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    search('dsa love babbar');
  }

   Future<void> initSpeechState() async {
    _logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: _logEvents,
      );
      if (hasSpeech) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        _localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
      }
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
      });
    }
  }


    void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    final pauseFor = int.tryParse(_pauseForController.text);
    final listenFor = int.tryParse(_listenForController.text);
    final options = SpeechListenOptions(
        onDevice: _onDevice,
        listenMode: ListenMode.confirmation,
        cancelOnError: true,
        partialResults: true,
        autoPunctuation: true,
        enableHapticFeedback: true);
    // Note that `listenFor` is the maximum, not the minimum, on some
    // systems recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: listenFor ?? 10),
      // pauseFor: Duration(seconds: pauseFor ?? 3),
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      listenOptions: options,
    );
    setState(() {});
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

List<Data>? youtubeData;
  Future<void> search(String query) async {
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
   // Inside your Drawer widget
drawer: Drawer(
  child: SafeArea(
    child: Column(
      children: [
        Container(
          height: 50,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Center(
              child: Image.asset(
                'assets/youtube/youtube.png',
                height: 50,
                width: 50,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ...items.map((item) {
                return Column(
                  children: [
                    ListTile(
                      leading: Image.asset(
                        item['image'] ?? '',
                        width: 30,
                        height: 30,
                      ),
                      title: Text(item['text'] ?? ''),
                      onTap: () {
                        // Pass the selected item's text back when the drawer closes
                        Navigator.pop(context, item['text']);
                      },
                    ),
                    if (items.indexOf(item) == 10)
                      const Divider(color: Colors.grey),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
        Container(
          height: 50,
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Center(
              child: Text(
                'Privacy Policy * Terms of Service',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),


      backgroundColor: AppColors.youtubeBg,
      body: SafeArea(child:  
       SingleChildScrollView(child: 
       Column( children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const SizedBox(width: 6,),
    Container(
      child: Row(
        children: [
          Image.asset(
            'assets/youtube/youtube.png',
            height: 40,
            width: 40,
          ),
        ],
      ),
    ),
    
    Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      height: 50,
      width: MediaQuery.of(context).size.width - 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey[600]),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 0.0),
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
                                spreadRadius: level * 1.5,
                                color: Colors.black.withOpacity(.05))
                          ],
                          color: Colors.green,
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [
                              BoxShadow(
                                blurRadius: .26,
                                spreadRadius: _hasSpeech || !speech.isListening ? level * 1.5 : 0,
                                color: _hasSpeech || !speech.isListening ? Colors.black.withOpacity(.05): Colors.transparent )
                              ],
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.mic,size: 20,),
                              onPressed: () {
                                if(!_hasSpeech){
                                  initSpeechState().then((_){
                                    if(_hasSpeech || !speech.isListening){
                                      startListening();
                                    }
                                });
                                }
                              },
                            ),
                          ),),
                          const SizedBox(width: 8,),
                  GestureDetector(
                    onTap: (){
                      search(_searchController.text);
                    },
                    child: Image.asset('assets/youtube/search-interface-symbol.png',scale: 30,),),
                    const SizedBox(width: 8,),
                  if (_searchController.text.isNotEmpty)
                  GestureDetector(
                    onTap: (){
                      setState(() {
                          _searchController.clear();
                        });
                    },
                    child: Image.asset('assets/youtube/close.png',scale: 25,),),
                    const SizedBox(width: 8,)
                ],
              ),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    ),
  ],
),


        //     Container(
        //   margin: const EdgeInsets.only(left: 10, right: 10, top: 0),
        //   height: 50,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(25),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey.withOpacity(0.3),
        //         spreadRadius: 1,
        //         blurRadius: 5,
        //         offset: const Offset(0, 3),
        //       ),
        //     ],
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 15.0),
        //     child: TextFormField(
        //       controller: _searchController,
        //       decoration: InputDecoration(
        //         hintText: 'Search',
        //         hintStyle: TextStyle(color: Colors.grey[600]),
        //         suffixIcon: Padding(
        //           padding: const EdgeInsets.only(right: 0.0),
        //           child: Row(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Container(
        //                 width: 40,
        //                 height: 40,
        //                 alignment: Alignment.center,
        //                 decoration: BoxDecoration(
        //                   boxShadow: [
        //                     BoxShadow(
        //                         blurRadius: .26,
        //                         spreadRadius: level * 1.5,
        //                         color: Colors.black.withOpacity(.05))
        //                   ],
        //                   color: Colors.green,
        //                   borderRadius: const BorderRadius.all(Radius.circular(50)),
        //                 ),
        //                 child: Container(
        //                     width: 40,
        //                     height: 40,
        //                     alignment: Alignment.center,
        //                     decoration: BoxDecoration(
        //                       boxShadow: [
        //                       BoxShadow(
        //                         blurRadius: .26,
        //                         spreadRadius: _hasSpeech || !speech.isListening ? level * 1.5 : 0,
        //                         color: _hasSpeech || !speech.isListening ? Colors.black.withOpacity(.05): Colors.transparent )
        //                       ],
        //                       color: Colors.white,
        //                       borderRadius: const BorderRadius.all(Radius.circular(50)),
        //                     ),
        //                     child: IconButton(
        //                       icon: const Icon(Icons.mic),
        //                       onPressed: () {
        //                         if(!_hasSpeech){
        //                           initSpeechState().then((_){
        //                             if(_hasSpeech || !speech.isListening){
        //                               startListening();
        //                             }
        //                         });
        //                         }
        //                       },
        //                     ),
        //                   ),),
        //                 IconButton(
        //                   onPressed: (){
        //                     search(_searchController.text);
        //                   },
        //                 icon: Icon(
        //                 Icons.search,
        //                 color: Colors.grey[600],
        //               ),
        //               ),

        //               if(_searchController.text.isNotEmpty)
        //               IconButton(
        //                 icon: Icon(
        //                   Icons.clear,
        //                   color: Colors.grey[600],
        //                 ),
        //                 onPressed: () {
        //                   setState(() {
        //                     _searchController.clear();
        //                   });
        //                 },
        //               ),
        //             ],
        //           ),
        //         ),
        //         border: InputBorder.none,
        //         contentPadding: const EdgeInsets.symmetric(vertical: 15),
        //       ),
        //     ),
        //   ),
        // ),

        const SizedBox(height: 10,),
         SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:  Row(
              children: [ 
              const SizedBox(width: 10,),
              GestureDetector(
                onTap: (){
                 _scaffoldKey.currentState?.openDrawer();
                },
                child: Container(
                width: 40,
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: YoutubeAppColors.lightGreyBox
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 0),
                  padding: const EdgeInsets.all(4.0),
                  child: Center(child: Image.asset('assets/youtube/compass.png',height: 17,width: 17,color: YoutubeAppColors.black))
                )
              ),),
                const SizedBox(width: 10,),
              GestureDetector(
                  onTap: (){
                  setState(() {
                    all = true;
                    yakshagana = false;
                    flutter = false;
                    music = false;
                    live = false;
                    computerProgramming = false;
                  });
                  search('');
                },
                child:  Container(
                width: 50,
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: all == true ?  YoutubeAppColors.black: YoutubeAppColors.lightGreyBox
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child:
                   Center(child: Text('All',style: TextStyle(color: all == true ? YoutubeAppColors.white : YoutubeAppColors.black,fontSize: 12,fontWeight: FontWeight.bold),))
                )
              ),),
              const SizedBox(width: 8,),
              GestureDetector(
                 onTap: (){
                  setState(() {
                    all = false;
                    yakshagana = true;
                    flutter = false;
                    music = false;
                    live = false;
                    computerProgramming = false;
                  });
                  search('Yakshagana');
                },
                child: Container(
                width: 90,
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: yakshagana == true ?  YoutubeAppColors.black: YoutubeAppColors.lightGreyBox,
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child:
                   Center(child: Text('Yakshagana',style: TextStyle(color: yakshagana == true ? YoutubeAppColors.white : YoutubeAppColors.black,fontSize: 12,fontWeight: FontWeight.bold),))
                )
              ),),
              const SizedBox(width: 8,),
              GestureDetector(
                  onTap: (){
                  setState(() {
                    all = false;
                    yakshagana = false;
                    flutter = true;
                    music = false;
                    live = false;
                    computerProgramming = false;
                  });
                  search('flutter');
                },
                child:  Container(
                width: 70,
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: flutter == true ?  YoutubeAppColors.black: YoutubeAppColors.lightGreyBox
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child:
                   Center(child: Text('Flutter',style: TextStyle(color: flutter == true ? YoutubeAppColors.white : YoutubeAppColors.black,fontSize: 12,fontWeight: FontWeight.bold),))
                )
              ),),
               const SizedBox(width: 8,),
               GestureDetector(
                 onTap: (){
                  setState(() {
                    all = false;
                    yakshagana = false;
                    flutter = false;
                    music = true;
                    live = false;
                    computerProgramming = false;
                  });
                  search('music');
                },
                child: Container(
                width: 70,
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: music == true ?  YoutubeAppColors.black: YoutubeAppColors.lightGreyBox
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child:
                   Center(child: Text('Music',style: TextStyle(color: music == true ? YoutubeAppColors.white : YoutubeAppColors.black,fontSize: 12,fontWeight: FontWeight.bold),))
                )
              ),),
              const SizedBox(width: 8,),
              GestureDetector(
                 onTap: (){
                  setState(() {
                    all = false;
                    yakshagana = false;
                    flutter = false;
                    music = false;
                    live = true;
                    computerProgramming = false;
                  });
                  search('Live');
                },
                child:  Container(
                width: 60,
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: live == true ?  YoutubeAppColors.black: YoutubeAppColors.lightGreyBox
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child:
                   Center(child: Text('Live',style: TextStyle(color: live == true ? YoutubeAppColors.white : YoutubeAppColors.black,fontSize: 12,fontWeight: FontWeight.bold),))
                )
              ),),
              const SizedBox(width: 8,),
               GestureDetector(
                 onTap: (){
                  setState(() {
                    all = false;
                    yakshagana = false;
                    flutter = false;
                    music = false;
                    live = false;
                    computerProgramming = true;
                  });
                  search('Computer Programming');
                },
                child:  Container(
                width: 155,
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: computerProgramming == true ?  YoutubeAppColors.black: YoutubeAppColors.lightGreyBox
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child:
                   Center(child: Text('Computer Programming',style: TextStyle(color: computerProgramming == true ? YoutubeAppColors.white : YoutubeAppColors.black,fontSize: 12,fontWeight: FontWeight.bold),))
                )
              ),),
          const SizedBox(width: 8,),

          ],)
          ,),
          const SizedBox(height: 5,),
      SingleChildScrollView(child:  
      _listView(youtubeData??[]),)
      ],
    )
    )
    ));
  }

  // Handle settings button press
  void _onSettingsPressed() {
    setState(() {
      // For demonstration, toggle between 0 and 1
      selectedItemIndex = selectedItemIndex == 0 ? 1 : 0;
    });
  }

  // Header Bottom Bar widget
  Row _headerBottomBarWidget() {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.settings,
          color: YoutubeAppColors.white,
        ),
      ],
    );
  }

Widget _headerWidget(BuildContext context) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.3,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/day29/news.jpg'),
        fit: BoxFit.cover,
      ),
    ),
  );
}

ListView _listView(List<Data> data) {
String formatViewCount(String viewCount) {
  int count = int.tryParse(viewCount) ?? 0;

  if (count >= 1000000) {
    return '${(count / 1000000).toStringAsFixed(1)}M';
  } else if (count >= 1000) {
    return '${(count / 1000).toStringAsFixed(1)}K';
  } else {
    return count.toString();
  }
}

String formatDate(String dateString) {
  try {
    DateTime date = DateTime.parse(dateString);
    return '${date.month}-${date.day}-${date.year}';
    
  } catch (e) {
    return 'Invalid Date';
  }
}
  return ListView.builder(
    padding: const EdgeInsets.only(top: 10.0),
    physics: const BouncingScrollPhysics(),
    itemCount: _isLoading ? 5 : data.length,
    shrinkWrap: true,
    itemBuilder: (context, index) {
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

        return  Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: YoutubePlayer(
                    progressColors: const ProgressBarColors(backgroundColor: YoutubeAppColors.grey, playedColor: YoutubeAppColors.red),
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                    bottomActions: [
                      CurrentPosition(),
                      ProgressBar(isExpanded: true),
                      RemainingDuration(),
                    ],
                  ),
                ),
                const SizedBox(height: 7.0),

                Padding(padding: const EdgeInsets.only(left:8.0,right: 8.0,),
                child:
                 Column(children: [                
                  Text(
                  item.title ?? "Untitled Video",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_circle, size: 15.0, color: Colors.grey),
                        const SizedBox(width: 5.0),
                          Container(child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                            child:  Text(
                          '${item.channelTitle}' == null.toString() || '${item.channelTitle}' == '' ? "Unknown Channel": '${item.channelTitle}',
                          style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent,
                          ),
                        ),)),
                      
                      ],
                    ),
                    const SizedBox(width: 5,),
                    Row(
                      children: [
                        const Icon(Icons.circle, size: 7.0, color: Colors.grey),
                        const SizedBox(width: 5.0),
                        Text(
                          formatViewCount(item.viewCount??'') ?? "No views",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 5,),
                    Row(
                      children: [
                        const Icon(Icons.circle, size: 7.0, color: Colors.grey),
                        const SizedBox(width: 5.0),
                        Text(
                          formatDate(item.publishedAt??'') ?? '',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),],))],
            ));
       
      }
    },
  );
}

  Widget _buildSkeletonLoader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 7.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                children: [
                  Container(
                    height: 20.0,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.account_circle, size: 15.0, color: Colors.grey),
                          const SizedBox(width: 5.0),
                          Container(
                            height: 10.0,
                            width: 100.0,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Row(
                        children: [
                          const Icon(Icons.circle, size: 7.0, color: Colors.grey),
                          const SizedBox(width: 5.0),
                          Container(
                            height: 10.0,
                            width: 60.0,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Row(
                        children: [
                          const Icon(Icons.circle, size: 7.0, color: Colors.grey),
                          const SizedBox(width: 5.0),
                          Container(
                            height: 10.0,
                            width: 50.0,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      debugPrint('$eventTime $eventDescription');
    }
  }

    void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
      setState(() {
        _searchController.text = removeTrueOrFalse(lastWords);
      });
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  
  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = status;
    });
  }

  String removeTrueOrFalse(String input) {
  return input.replaceAll(RegExp(r' - (true|false)$'), '');
}

}
