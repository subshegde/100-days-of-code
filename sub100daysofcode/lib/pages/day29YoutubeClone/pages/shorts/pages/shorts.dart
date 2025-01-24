import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sub100daysofcode/pages/day29YoutubeClone/configs/config.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/shorts/components/bottomSheets.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/shorts/components/shortItem.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/shorts/model/youtubeShortsModel.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/constants/appcolors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Shorts extends StatefulWidget {
  const Shorts({super.key});

  @override
  State<Shorts> createState() => _ShortsState();
}

class _ShortsState extends State<Shorts> {
  bool _isLoading = false;
  List<ShortsData> shortsList = [];

  @override
  void initState() {
    super.initState();
    getShorts();
  }

  Future<void> getShorts() async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse(
      '${baseUrl}shorts/soundAttribution?params=8gU1CjMSMQoLMzFaR01oWjFlejgSCzMxWkdNaFoxZXo4GgtTQWoxZktNZVMyOCIICLiCBxICCCI%253D',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-rapidapi-key': 'ec06247fd2mshe27f87049c5fef8p1ced56jsn2fe21f0a6890',
          'x-rapidapi-host': 'yt-api.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedBody = jsonDecode(response.body);
        YouTubeShortsModel model = YouTubeShortsModel.fromJson(parsedBody);
        shortsList.clear();
        setState(() {
          shortsList = model.data?.take(5).toList() ?? [];
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
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: shortsList.length,
                            itemBuilder: (context, index) {
                              final item = shortsList[index];
                              return ShortsItems(
                                videoId: item.videoId ?? '',
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 0,
              child: Row(
                children: [
                  IconButton(
                    icon: Container(child: Image.asset('assets/youtube/shorts/search-interface-symbol.png',color: YoutubeAppColors.white,width: 20,height: 20,),),
                    onPressed: () {
                    },
                  ),
                  IconButton(
                    icon: Container(child: Image.asset('assets/youtube/shorts/dots.png',color: YoutubeAppColors.white,width: 20,height: 20,),),
                    onPressed: () {
                      Sheets.showBottomMainSheet(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
