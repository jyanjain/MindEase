import 'package:flutter/material.dart';

class NewSession extends StatefulWidget {
  const NewSession({super.key});

  @override
  State<NewSession> createState() => _NewSessionState();
}

class _NewSessionState extends State<NewSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextButton(onPressed: (){

     // i want the real time data to be fetched when this is on tapped and the monitor the data

        }, child: Text('START SESSION'))
      ],),
    );
  }
}
