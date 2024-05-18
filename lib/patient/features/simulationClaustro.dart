import 'package:flutter/material.dart';
import 'package:vr_therapy_ipd/patient/questionarre_acrophobia.dart';
import 'package:vr_therapy_ipd/patient/questionnaire_claustrophobia.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class VideoPlayerItemc extends StatefulWidget {
  final String videoUrl;

  VideoPlayerItemc({required this.videoUrl});

  @override
  _VideoPlayerItemcState createState() => _VideoPlayerItemcState();
}

class _VideoPlayerItemcState extends State<VideoPlayerItemc> {
  late YoutubePlayerController _controller;
  String arduinoData =
      ''; // Variable to store Arduino data received from the server
  bool thresholdExceeded = false;
  bool pagePushed = false; // Track if the page has been pushed
  static const int thresholdValue = 100; // Adjust the threshold value as needed
  String phobia = "No";

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    // Start fetching Arduino data periodically
    Timer.periodic(const Duration(seconds: 1), (timer) {
      startPulseMeter();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> startPulseMeter() async {
    try {
      // Make HTTP request to your Flask API endpoint
      final response = await http
          .get(Uri.parse('http://192.168.194.60:5000/api/serial_data'));
      if (response.statusCode == 200) {
        // Parse JSON response
        final data = jsonDecode(response.body.toString());
        final newData = int.parse(data['data']);

        // Check if heartbeat exceeds threshold
        if (newData > thresholdValue && !pagePushed) {
          setState(() {
            thresholdExceeded = true;
            phobia = "Yes";
            pagePushed = true; // Set pagePushed to true
          });
          // Pause the video
          _controller.pause();
          // Move to separate screen
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuestionnairePagec(
                      phobiaS: phobia,
                    )),
          );
          // return;
        }

        // Update UI with Arduino data
        setState(() {
          arduinoData = newData.toString();
          // Update the UI state with the received Arduino data
          print('Received Arduino data: $arduinoData');
        });
      } else {
        // Handle error if API request fails
        print('Failed to fetch Arduino data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error fetching Arduino data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    startPulseMeter();
                  },
                  child: Text('Play claustro'),
                ),
                SizedBox(width: 16.0),
                Text(
                  'Arduino Data: $arduinoData', // Display Arduino data in the UI
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
