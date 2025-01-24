import 'dart:convert';
import 'dart:math';

import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:sub100daysofcode/constants/appColors.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/components/cameraView.dart';
import 'package:http/http.dart' as http;
import 'package:sub100daysofcode/pages/day29YoutubeClone/components/navbar.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/models/youtubeModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DraggableHomeWidget extends StatefulWidget {
  const DraggableHomeWidget({Key? key}) : super(key: key);

  @override
  _DraggableHomeWidgetState createState() => _DraggableHomeWidgetState();
}

class _DraggableHomeWidgetState extends State<DraggableHomeWidget> {
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

  bool compass = false;
  bool all = true;
  bool yakshagana = false;
  bool flutter = false;
  bool music = false;
  bool live = false;
  bool computerProgramming = false;

  @override
  void initState() {
    super.initState();
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
      backgroundColor: AppColors.youtubeBg,
      body: SafeArea(child:  
       DraggableHome(

      backgroundColor: AppColors.youtubeBg,
      leading: const Icon(Icons.arrow_back_ios,color: AppColors.white,),
      title: const Text("YouTube Player",style: TextStyle(color: AppColors.white),),
      actions: [
        IconButton(onPressed: _onSettingsPressed, icon: const Icon(Icons.settings,color: AppColors.white,)),
      ],
      headerWidget: _headerWidget(context),
      headerBottomBar: _headerBottomBarWidget(),
      body: [
        //  TextButton(
        //   onPressed: _hasSpeech ? null : initSpeechState,
        //   child: const Text('Initialize'),
        // ),
        
            Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 0),
          height: 50,
          width: double.infinity,
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFormField(

              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey[600]),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
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
                            width: 40,
                            height: 40,
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
                              icon: const Icon(Icons.mic),
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
                        IconButton(
                          onPressed: (){
                            search(_searchController.text);
                          },
                        icon: Icon(
                        Icons.search,
                        color: Colors.grey[600],
                      ),
                      ),

                      if(_searchController.text.isNotEmpty)
                      IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,),
         SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:  Row(
              children: [ 
              const SizedBox(width: 10,),
              GestureDetector(
                onTap: (){
                  setState(() {
                    compass = true;
                    all = false;
                    yakshagana = false;
                    flutter = false;
                    music = false;
                    live = false;
                    computerProgramming = false;
                  });
                },
                child: Container(
                width: 40,
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: compass == true ? AppColors.white : const Color.fromARGB(255, 53, 53, 53),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 0),
                  padding: const EdgeInsets.all(4.0),
                  child: Center(child: Image.asset('assets/youtube/compass.png',height: 17,width: 17,color: compass == true ? AppColors.black : AppColors.white))
                )
              ),),
                const SizedBox(width: 10,),
              GestureDetector(
                  onTap: (){
                  setState(() {
                    compass = false;
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
                  color: all == true ? AppColors.white : const Color.fromARGB(255, 53, 53, 53),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child:
                   Center(child: Text('All',style: TextStyle(color: all == true ? AppColors.black : AppColors.white,fontSize: 12,fontWeight: FontWeight.bold),))
                )
              ),),
              const SizedBox(width: 8,),
              GestureDetector(
                 onTap: (){
                  setState(() {
                    compass = false;
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
                  color: yakshagana == true ? AppColors.white : const Color.fromARGB(255, 53, 53, 53),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child:
                   Center(child: Text('Yakshagana',style: TextStyle(color: yakshagana == true ? AppColors.black : AppColors.white,fontSize: 12,fontWeight: FontWeight.bold),))
                )
              ),),
              const SizedBox(width: 8,),
              GestureDetector(
                  onTap: (){
                  setState(() {
                    compass = false;
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
                  color: flutter == true ? AppColors.white : const Color.fromARGB(255, 53, 53, 53),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child:
                   Center(child: Text('Flutter',style: TextStyle(color: flutter == true ? AppColors.black : AppColors.white,fontSize: 12,fontWeight: FontWeight.bold),))
                )
              ),),
               const SizedBox(width: 8,),
               GestureDetector(
                 onTap: (){
                  setState(() {
                    compass = false;
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
                  color: music == true ? AppColors.white : const Color.fromARGB(255, 53, 53, 53),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child:
                   Center(child: Text('Music',style: TextStyle(color: music == true ? AppColors.black : AppColors.white,fontSize: 12,fontWeight: FontWeight.bold),))
                )
              ),),
              const SizedBox(width: 8,),
              GestureDetector(
                 onTap: (){
                  setState(() {
                    compass = false;
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
                  color: live == true ? AppColors.white : const Color.fromARGB(255, 53, 53, 53),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child:
                   Center(child: Text('Live',style: TextStyle(color: live == true ? AppColors.black : AppColors.white,fontSize: 12,fontWeight: FontWeight.bold),))
                )
              ),),
              const SizedBox(width: 8,),
               GestureDetector(
                 onTap: (){
                  setState(() {
                    compass = false;
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
                  color: computerProgramming == true ? AppColors.white : const Color.fromARGB(255, 53, 53, 53),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(4.0),
                  child:
                   Center(child: Text('Computer Programming',style: TextStyle(color: computerProgramming == true ? AppColors.black : AppColors.white,fontSize: 12,fontWeight: FontWeight.bold),))
                )
              ),),
          const SizedBox(width: 8,),

          ],)
          ,),
          const SizedBox(height: 5,),
      SingleChildScrollView(child:  
      _listView(youtubeData??[]),)
      ],
      fullyStretchable: true,
      expandedBody: const CameraPreview(),
      appBarColor: Colors.black,
    )));
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
          color: Colors.white,
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
  return ListView.builder(
    padding: const EdgeInsets.only(top: 10.0),
    physics: const BouncingScrollPhysics(), // Makes scrolling smoother
    itemCount: _isLoading ? 5 : data.length, // Show 5 skeleton loaders while loading
    shrinkWrap: true,
    itemBuilder: (context, index) {
      if (_isLoading) {
        // Show skeleton loader if loading
        return _buildSkeletonLoader(context);
      } else {
        // Show actual video content once data is available
        final item = data[index];

        final YoutubePlayerController _controller = YoutubePlayerController(
          initialVideoId: item.videoId ?? 'default_video_id',
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        );

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5.0, // Adds shadow for better depth effect
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    bottomActions: [
                      CurrentPosition(),
                      ProgressBar(isExpanded: true),
                      RemainingDuration(),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  item.title ?? "Untitled Video",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  item.description ?? "No description available.",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14.0,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_circle, size: 18.0, color: Colors.grey),
                        const SizedBox(width: 5.0),
                          Container(child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                            child:  Text(
                          item.channelTitle ?? "Unknown Channel",
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent,
                          ),
                        ),)),
                      
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.visibility, size: 18.0, color: Colors.grey),
                        const SizedBox(width: 5.0),
                        Text(
                          item.viewCount ?? "0 views",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    },
  );
}

// Build Skeleton Loader with shimmer effect
Widget _buildSkeletonLoader(BuildContext context) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 5.0,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15.0),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 120.0,
              height: 20.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 15.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 80.0,
                  height: 15.0,
                  color: Colors.white,
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 80.0,
                  height: 15.0,
                  color: Colors.white,
                ),
              ),
            ],
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
