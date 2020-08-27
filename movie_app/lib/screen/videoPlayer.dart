import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:movie_app/style/theme.dart' as Styler;

class VideoPlayScreen extends StatefulWidget {
  final YoutubePlayerController controller;
  VideoPlayScreen({@required this.controller});
  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState(controller);
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  final YoutubePlayerController controller;
  _VideoPlayScreenState(this.controller);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styler.Colors.mainColor,
      body: Stack(
        children: [
          Center(
            child: YoutubePlayer(controller: controller),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(
                EvaIcons.closeCircle,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
