import 'package:flutter/material.dart';

class BottomNavigationButton extends StatelessWidget {
  BottomNavigationButton({this.tabIndex, this.onTab});
  final int tabIndex;
  final Function onTab;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: tabIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          title: Text('News'),
          backgroundColor: Color(0xFF451C1C),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library),
          title: Text('Movies'),
          backgroundColor: Color(0xFF451C1C),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.slideshow),
          title: Text('Sports'),
          backgroundColor: Color(0xFF451C1C),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assistant),
          title: Text('Christians'),
          backgroundColor: Color(0xFF451C1C),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          title: Text('Documentary'),
          backgroundColor: Color(0xFF451C1C),
        ),
      ],
      onTap: onTab,
    );
  }
}