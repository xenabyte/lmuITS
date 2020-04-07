import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lmuits/components/bottom_navigation_button.dart';
import 'package:lmuits/screens/documentary_page.dart';
import 'package:lmuits/screens/movies_page.dart';
import 'package:lmuits/screens/player_page.dart';
import 'package:lmuits/screens/sermons_page.dart';
import 'package:lmuits/screens/sports_page.dart';
import 'package:lmuits/services/networking.dart';
import 'package:lmuits/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class NewsPage extends StatefulWidget {
  static const id = 'news_page';

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    getNewsChannels();
  }

  int _currentIndex = 0;
  int carouselIndex = 0;
  String pageName = 'news';
  List newsChannels = [];

  void getNewsChannels() async {
    NetworkHelper networkHelper = NetworkHelper(kUrl + pageName);
    List data = await networkHelper.getData();
    setState(()  {
      newsChannels = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        appBar: AppBar(
          title: Text('News Channels'),
          backgroundColor: Color(0xFF3E793A),
        ),
        body: Container(
          child: newsChannels.length == 0 ? Center(
            child: SpinKitRotatingPlain(
              color: Color(0xFF3E793A),
              size: 50,
            ),
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CarouselSlider.builder(
                itemCount: newsChannels.length,
                autoPlay: true,
                initialPage: 1,
                height: 600,
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
                        Navigator.pushNamed(context, PlayerPage.id);
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
                                         image: new NetworkImage(kMediaPath+newsChannels[itemIndex]['channel_image']),
                                         fit: BoxFit.cover
                                     )
                                 )
                               ),
                             ),
                              ListTile(
                                contentPadding: EdgeInsets.all(10.0),
                                title: Text(newsChannels[itemIndex]['channel_name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
              Navigator.pushNamed(
                  context,
                  index == 0
                      ? NewsPage.id
                      : index == 1
                      ? MoviesPage.id
                      : index == 2
                      ? SportsPage.id
                      : index == 3
                      ? SermonsPage.id
                      : DocumentaryPage.id);
            });
          },
        ));
  }
}
