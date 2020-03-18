import 'package:blog_test/blogpage.dart';
import 'package:blog_test/home.dart';
import 'package:blog_test/main_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  static const String id='Gallery';
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  Future gallery()async{
    var firestore= Firestore.instance;
    QuerySnapshot snap = await firestore.collection('gallery').getDocuments();
    return snap.documents;
  }

  //pull to refresh
  Future<Null> getReffreshgallery()async{
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      gallery();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Gallery info',style: TextStyle(fontSize: 22.0)),
        centerTitle: true,
        actions: <Widget>[

          Icon(Icons.search,size: 30,),
        ],
      ),
      drawer:Navigation(),

      body: FutureBuilder(
        future: gallery(),
        builder:(context, snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else{
            return RefreshIndicator(
              onRefresh: getReffreshgallery,
              child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                var ourData=snapshot.data[index];
                return Card(
                  margin: EdgeInsets.all(13.0),
                  elevation: 12.0,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: InkWell(
                    onTap: ()
                    {
                      customDialog(context, ourData.data['img']);

                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(ourData.data['img'],fit: BoxFit.cover,),
                    ),
                  ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
  customDialog(BuildContext context, String img){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(img,fit: BoxFit.cover,),
            ),
          ),
        );
      }
    );
  }
}
