import 'package:flutter/material.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/constants/appcolors.dart';
import 'package:sub100daysofcode/pages/day29YoutubeClone/pages/shorts/components/bottomSheets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShortsItems extends StatefulWidget {
  final String videoId;
  const ShortsItems({super.key, required this.videoId});

  @override
  State<ShortsItems> createState() => _ShortsItemsState();
}

class _ShortsItemsState extends State<ShortsItems> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId ?? 'vZ6ZJwoVdlc', // Fallback video ID if widget.videoId is null
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Center(
          child: Container(
            child: YoutubePlayer(
              controller: _controller,
              aspectRatio: 9 / 16.4,
              progressColors: const ProgressBarColors(
                backgroundColor: Colors.grey,
                playedColor: Colors.red,
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
              bottomActions: [
                CurrentPosition(),
                ProgressBar(isExpanded: true),
                RemainingDuration(),
              ],
            ),
          ),
        ),

        Positioned(
  bottom: 80,
  left: 0,
  child: IconButton(
    icon: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          width: 30,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 15, 
            child: ClipOval(
              child: Image.asset(
                'assets/youtube/shorts/user.png',
                color: YoutubeAppColors.white,
                fit: BoxFit.cover,
                width: 30, 
                height: 30,
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        const Text(
          '@username',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 8,),
        GestureDetector(
          onTap: (){},
          child: Container(
            height: 35,
            width: 80,
            decoration: BoxDecoration(color: YoutubeAppColors.white,borderRadius: BorderRadius.circular(20)),
          child: const Center(child: Text('Subscribe',style: TextStyle(color: YoutubeAppColors.grey800Color,fontSize: 12),)),
        ),)

      ],
    ),
    onPressed: () {
    },
  ),
),

        Positioned(
          top: 270,
          right: 10,
          child: IconButton(
            icon: Column(
              children: [
                Image.asset('assets/youtube/shorts/like.png',height: 25,width: 25,color: YoutubeAppColors.white),
                const SizedBox(height: 6,),
                const Text('Likes',style: TextStyle(color: YoutubeAppColors.white,fontSize: 12),)
              ],
            ) ,
            onPressed: () {
            },
          ),
        ),

        Positioned(
          top: 340,
          right: 10,
          child: IconButton(
            icon: Column(
              children: [
                Image.asset('assets/youtube/shorts/dont-like.png',height: 25,width: 25,color: YoutubeAppColors.white),
                const SizedBox(height: 6,),
                const Text('Dislikes',style: TextStyle(color: YoutubeAppColors.white,fontSize: 12),)
              ],
            ) ,
            onPressed: () {
            },
          ),
        ),

        Positioned(
          top: 410,
          right: 10,
          child: IconButton(
            icon: Column(
              children: [
                Image.asset(fit: BoxFit.cover,'assets/youtube/shorts/comment.png',height: 25,width: 25,color: YoutubeAppColors.white),
                const SizedBox(height: 6,),
                const Text('789',style: TextStyle(color: YoutubeAppColors.white,fontSize: 12),)
              ],
            ) ,
            onPressed: () {
            },
          ),
        ),

        Positioned(
          top: 480,
          right: 10,
          child: IconButton(
            icon: Column(
              children: [
                Image.asset(fit: BoxFit.cover,'assets/youtube/shorts/share.png',height: 25,width: 25,color: YoutubeAppColors.white),
                const SizedBox(height: 6,),
                const Text('789',style: TextStyle(color: YoutubeAppColors.white,fontSize: 12),)
              ],
            ) ,
            onPressed: () {
              Sheets.showBottomShareSheet(context);
            },
          ),
        ),

        Positioned(
          top: 550,
          right: 10,
          child: IconButton(
            icon: Column(
              children: [
                Image.asset(fit: BoxFit.cover,'assets/youtube/shorts/repeat.png',height: 25,width: 25,color: YoutubeAppColors.white),
                const SizedBox(height: 6,),
                const Text('789',style: TextStyle(color: YoutubeAppColors.white,fontSize: 12),)
              ],
            ) ,
            onPressed: () {
            },
          ),
        ),
        const Positioned(
          bottom: 30,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Video Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                'Video description......',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 5,
          right: 13,
          child: Container(
                margin: const EdgeInsets.only(left: 85),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/youtube/shorts/song.jpg',
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
        ),

         Positioned(
          bottom: 10,
          left: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Image.asset('assets/youtube/shorts/musical-note.png',height: 20,width: 20,color: YoutubeAppColors.white),
              const SizedBox(width: 6,),
              const Text(
                'Locked in heaven-Bruno Mars',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              ],),),

            ],
          ),
        ),
      ],
    );
  }
}
