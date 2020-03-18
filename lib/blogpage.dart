import 'package:blog_test/gallery.dart';
import 'package:blog_test/home.dart';
import 'package:blog_test/main_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BlogPage extends StatefulWidget {
  static const String id='BlodPage';
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
   Future getBlog()async{
     var firestore= Firestore.instance;
     QuerySnapshot snap = await firestore.collection('getBlog').getDocuments();
     return snap.documents;
   }

   //pull to refresh
   Future<Null> getReffreshblog()async{
     await Future.delayed(Duration(seconds: 2));
     setState(() {
       getBlog();
     });
   } List<MaterialColor> _colorsitem=[
     Colors.blue,Colors.red,Colors.green
   ] ;
   MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.teal,
        title: Text('Food Blog'),
        centerTitle: true,
        actions: <Widget>[

          Icon(Icons.search,size: 30,),
        ],
      ),
      drawer: Navigation(),
      body: FutureBuilder(
        future: getBlog(),
        builder: (context,snapshot){
          if (snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          } else{
            return RefreshIndicator(
              onRefresh: getReffreshblog,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                  var ourData= snapshot.data[index];
                  color=_colorsitem[index % _colorsitem.length];
                  return Container(
                    height: 210.0,
                    // width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 12.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(ourData.data['img'],
                              height: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,),
                            ),
                          ),
                          SizedBox(width: 10.0,),
                          Expanded(
                            flex: 2,
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top :1.0),
                                  child: Text(
                                    ourData.data['title'],style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,letterSpacing: 4.0,color: Colors.black54),
                                  ),
                                ),
                                SizedBox(height: 5.0,),
                                Container(
                                  child: Text(
                                    ourData.data['desc'],
                                    maxLines: 5,
                                    style: TextStyle(fontSize: 16.0,),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                SizedBox(height: 10.0,),


                                Align(
                                  alignment:Alignment.bottomRight ,

                                  child: InkWell(
                                    onTap: (){
                                      customDialog(context,
                                         ourData.data['img'],
                                          ourData.data['title'],
                                        ourData.data['desc'],
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10.0),
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),

                                      child: Text('Tap to Details',
                                      style: TextStyle(
                                          fontSize: 13.0,color: Colors.white),),
                                    ),
                                  ),
                                ),Divider(
                                  color: Colors.blueGrey,
                                  height: 2.0,
                                  thickness: 2.0,
                                  indent: 110.0,
                                  endIndent: 10.0,

                                ),

                              ],
                            ),
                          )
                        ],
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

  customDialog(BuildContext context , String img, String title, String desc){
    return showDialog(
      context: context,
      builder:(BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height/1.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                begin:Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blueAccent, Colors.white70,Colors.blueGrey],
              ),
            ),


            child: SingleChildScrollView(
              child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(0.0),
                  height: 150.0,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(img,
                      height: 150.0,
                      width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,),
                  ),
                ),
              //  Divider(height: 5.0,thickness: 5.0,),
                SizedBox(height: 10.0,),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 38.0,fontWeight: FontWeight.bold,color: Colors.redAccent,letterSpacing: 5.0),
                  ),
                ),
                SizedBox(height: 2.0,),
                Divider(height: 15.0,thickness: 5.0,),
                Container(
                  margin: EdgeInsets.all(15.0),
                  child: Text(
                    desc,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300,),
                  ),
                ),
              ],
              ),
            ),
          ),
        );
      }
    );
  }
}
