import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lmuits/components/bottom_navigation_button.dart';
import 'package:lmuits/constants.dart';
import 'package:lmuits/screens/documentary_page.dart';
import 'package:lmuits/screens/movies_page.dart';
import 'package:lmuits/screens/news_page.dart';
import 'package:lmuits/screens/player_page.dart';
import 'package:lmuits/screens/sports_page.dart';
import 'package:lmuits/services/networking.dart';

class SermonsPage extends StatefulWidget {
  static const id = 'sermons_page';

  @override
  _SermonsPageState createState() => _SermonsPageState();
}

class _SermonsPageState extends State<SermonsPage> {
  @override
  void initState() {
    super.initState();
    getChristiansChannels();
  }


  int _currentIndex = 3;
  int carouselIndex = 0;
  String pageName = 'christians';
  List christiansChannels = [];

  void getChristiansChannels() async {
    NetworkHelper networkHelper = NetworkHelper(kUrl + pageName);
    List data = await networkHelper.getData();
    setState(()  {
      christiansChannels = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: AppBar(
          title: Text('Christian Channels'),
          backgroundColor: Color(0xFF3E793A),
        ),
        body: Container(
          child: christiansChannels.length == 0 ? Center(
            child: SpinKitRotatingPlain(
              color: Color(0xFF3E793A),
              size: 50,
            ),
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CarouselSlider.builder(
                itemCount: christiansChannels.length,
                autoPlay: true,
                initialPage: 1,
                height: orientation == Orientation.portrait ? 600 : 250,
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
                        Navigator.pushNamed(context, PlayerPage.id, arguments: {
                          'channels': christiansChannels,
                          'channelName': christiansChannels[itemIndex]['channel_name'],
                          'channelUrl': christiansChannels[itemIndex]['channel_url']
                        });
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
                                            image: new NetworkImage(kMediaPath+christiansChannels[itemIndex]['channel_image']),
                                            fit: BoxFit.cover
                                        )
                                    )
                                ),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.all(10.0),
                                title: Text(christiansChannels[itemIndex]['channel_name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationButton(
          tabIndex: _currentIndex,
          onTab: (index) {
            setState(() {
              _currentIndex = index;
              Navigator.pushNamed(context,
                  index == 0 ? NewsPage.id : index == 1 ? MoviesPage.id : index == 2 ? SportsPage.id : index == 3 ? SermonsPage.id :  DocumentaryPage.id
              );
            });
          },
        )
    );
  }
}
