import 'package:blog_test/blogpage.dart';
import 'package:blog_test/gallery.dart';
import 'package:blog_test/homepage.dart';
import 'package:blog_test/main_drawer.dart';
import 'package:blog_test/thirdpage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  static const String id='Home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indexPage=1;
  final pageOptions=[

    BlogPage(),
    HomePage(),
    Gallery(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Navigation(),
      body: pageOptions[_indexPage],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.teal,
        height: 63.0,
        buttonBackgroundColor: Colors.teal,
        backgroundColor: Colors.white,
        index: 1,
        items: <Widget>[
          Icon(
            Icons.subtitles,size: 40,color: Colors.white,
          ),
          Icon(
            Icons.home,size: 40,color: Colors.white,
          ),
          Icon(
            Icons.add_a_photo,size: 40,color: Colors.white,
          ),
        ],
        onTap: (int index){
          setState(() {
            _indexPage=index;
          });
        }
      ),
    );
  }
}
