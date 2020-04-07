import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_video_player/flutter_simple_video_player.dart';
import 'package:lmuits/constants.dart';

class PlayerPage extends StatefulWidget {
  static const id = 'player_page';
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {

  @override
  void initState() {
    super.initState();
  }

  int carouselIndex = 0;
  String channelName;
  String channelUrl;
  List channels;

  void fetchUI () {
    final Map playerData = ModalRoute.of(context).settings.arguments as Map;
    setState(() {
      channelUrl = playerData['channelUrl'];
      channelName = playerData['channelName'];
      channels = playerData['channels'];
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchUI();
    return Scaffold(
        appBar: AppBar(
          title: Text(channelName),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 300,
              child: SimpleViewPlayer(channelUrl, isFullScreen: false,),
            ),
            SizedBox(
              height: 20,
              width: 200.0,
              child: Divider(
                color: Colors.teal.shade400,
              ),
            ),
            CarouselSlider.builder(
              itemCount: channels.length,
              autoPlay: true,
              initialPage: 1,
              height: 350,
              viewportFraction: 0.8,
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              enlargeCenterPage: true,
              onPageChanged: (index) {
                setState(() {
                  carouselIndex = index;
                });
              },
              itemBuilder: (BuildContext context, int itemIndex) => Container(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch, // add this
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  decoration: new BoxDecoration(
                                      borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                                      image: new DecorationImage(
                                          image: new NetworkImage(kMediaPath+channels[itemIndex]['channel_image']),
                                          fit: BoxFit.cover
                                      )
                                  )
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(10.0),
                              title: Text(channels[itemIndex]['channel_name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
