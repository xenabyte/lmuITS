import 'package:flutter/material.dart';
import 'package:flutter_simple_video_player/flutter_simple_video_player.dart';

class PlayerPage extends StatefulWidget {
  static const id = 'player_page';
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Demo"),
        ),
        body: Container(
          height: 300.0,
          child: SimpleViewPlayer("http://196.13.111.128:80/WorldSportHD/SD/index.m3u8", isFullScreen: false,),
        )
    );
  }
}
