import 'dart:async';

import 'package:flutter/material.dart';

class StreamsExample extends StatefulWidget {
  const StreamsExample({super.key});

  @override
  State<StreamsExample> createState() => _StreamsExampleState();
}

class _StreamsExampleState extends State<StreamsExample> {

  final TextEditingController _textEditingController = TextEditingController();
  StreamController<String> _streamController = StreamController<String>();
  late Stream<String> dataStream;

  @override  
  void initState(){
    super.initState();

    dataStream = _streamController.stream.asBroadcastStream();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Streams'),),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(children: [
          StreamBuilder<String>(
            stream: dataStream,
            builder: (context, snapshot) {

              if(snapshot.hasData){
                return Text(snapshot.data ?? 'Null Data',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold));
              }else{
              return Text('No Data',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold));

              }
            }
          ),

          StreamBuilder<String>(
            stream: dataStream,
            builder: (context, snapshot) {

              if(snapshot.hasData){
                return Text(snapshot.data ?? 'Null Data',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold));
              }else{
              return Text('No Data',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold));

              }
            }
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: 250,
            child: TextField(
              controller: _textEditingController,
            ),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            onPressed: () {
              _streamController.add(_textEditingController.text);
            },child: Text('OK'),)
        ],),
      )),
      
      );
  }
}