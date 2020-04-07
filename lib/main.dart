import 'package:flutter/material.dart';
import 'package:lmuits/screens/documentary_page.dart';
import 'package:lmuits/screens/movies_page.dart';
import 'package:lmuits/screens/news_page.dart';
import 'package:lmuits/screens/player_page.dart';
import 'package:lmuits/screens/sermons_page.dart';
import 'package:lmuits/screens/sports_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: NewsPage.id,
      routes: {
        NewsPage.id: (context) => NewsPage(),
        MoviesPage.id: (context) => MoviesPage(),
        SermonsPage.id: (context) => SermonsPage(),
        DocumentaryPage.id: (context) => DocumentaryPage(),
        SportsPage.id: (context) => SportsPage(),
        PlayerPage.id: (context) => PlayerPage(),
      },
    );
  }
}
