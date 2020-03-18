import 'package:blog_test/blogpage.dart';
import 'package:blog_test/gallery.dart';
import 'package:blog_test/home.dart';
import 'package:blog_test/homepage.dart';
import 'package:blog_test/thirdpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Navigation extends StatelessWidget {
  static const String id='Navigation';
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[

          UserAccountsDrawerHeader(
            accountName: Center(child: Text(' Food Blog',style: TextStyle(fontSize: 30.0),)),
            accountEmail: Center(child: Text('Food420@gmail.com')),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Colors.tealAccent,
                Colors.teal,
              ]),
              // color: Colors.blueGrey,
            ),
            otherAccountsPictures: <Widget>[
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('images/p.jpg'), fit: BoxFit.fill ),
                ),
              ),
            ],

          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BlogPage()));
            },
            title: Text('BlogPage',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
            leading: Icon(Icons.assignment,size: 30.0,),
          ), Divider(
            color: Colors.blueGrey,
            height: 2.0,
            thickness: 1.0,
            indent: 20.0,

          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
            },
            title: Text('Home',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
            leading: Icon(Icons.home,size: 30.0,),
          ), Divider(
            color: Colors.blueGrey,
            height: 2.0,
            thickness: 1.0,
            indent: 20.0,
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Gallery()));
            },
            title: Text('Gallery',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
            leading: Icon(Icons.accessibility,size: 30.0,),
          ), Divider(
            color: Colors.blueGrey,
            height: 2.0,
            thickness: 1.0,
            indent: 20.0,

          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pop();
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Gallery()));
            },
            title: Text('LogOut',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
            leading: Icon(Icons.account_circle,size: 30.0,),

          ), Divider(
            color: Colors.blueGrey,
            height: 2.0,
            thickness: 1.0,
            indent: 20.0,

          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {

  IconData icon;
  String text;
  Function OnTap;


  CustomListTile(this.icon, this.text, this.OnTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade400),),
      ),
      child: InkWell(
        splashColor: Colors.blueAccent,
        onTap: OnTap,
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
             Padding(
               padding: EdgeInsets.only(left: 10.0),
               child: Row(
                 children: <Widget>[
                   Icon(icon),
                   Padding(
                       padding: EdgeInsets.only(left: 8.0,right: 8.0),
                       child: Text(text, style: TextStyle(
                         fontSize: 20.0, fontWeight: FontWeight.bold,
                       ),
                       ),
                   ),
                 ],
               ),
             ),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}
