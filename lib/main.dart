import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

void main() => runApp(MaterialApp(home: WorkoutApp()));

class WorkoutApp extends StatefulWidget {
  @override
  _WorkoutAppState createState() => _WorkoutAppState();
}

class _WorkoutAppState extends State<WorkoutApp> {
  int currentIndex = 0;
  VideoPlayerController? _controller;
  
  final List<String> videos = ['1.mp4', '2.mp4', '3.mp4', '4.mp4', '5.mp4', '6.mp4', '7.mp4', '8.mp4', '9.mp4'];

  @override
  void initState() {
    super.initState();
    _playVideo(0);
  }

  void _playVideo(int index) {
    _controller?.dispose();
    _controller = VideoPlayerController.asset('assets/videos/${videos[index]}')
      ..initialize().then((_) { setState(() {}); _controller!.play(); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _controller?.value.isInitialized == true 
            ? AspectRatio(aspectRatio: _controller!.value.aspectRatio, child: VideoPlayer(_controller!))
            : CircularProgressIndicator(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(icon: Icon(Icons.arrow_back), onPressed: () => setState(() { if(currentIndex > 0) _playVideo(--currentIndex); })),
            IconButton(icon: Icon(Icons.arrow_forward), onPressed: () => setState(() { if(currentIndex < videos.length - 1) _playVideo(++currentIndex); })),
          ]),
        ],
      ),
    );
  }
}

