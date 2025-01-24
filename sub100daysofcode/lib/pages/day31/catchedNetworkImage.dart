import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Catchednetworkimage extends StatefulWidget {
  const Catchednetworkimage({super.key});

  @override
  State<Catchednetworkimage> createState() => _CatchednetworkimageState();
}

class _CatchednetworkimageState extends State<Catchednetworkimage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Center(child: Column(children: [
      Container(child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
                imageUrl:
                    'https://images.unsplash.com/photo-1532264523420-881a47db012d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9',
              ),),
    ],),)),);
  }
}