import 'package:blog_test/blogpage.dart';
import 'package:blog_test/gallery.dart';
import 'package:blog_test/home.dart';
import 'package:blog_test/main_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id='HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getHomePost()async{
    var firestore=Firestore.instance;
    QuerySnapshot snap =await firestore.collection('homedata').getDocuments();
    return snap.documents;
  }
  Future<Null>getRefresh()async{
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getHomePost();
    });
  }
  List<MaterialColor> _colorsitem=[
    Colors.blue,Colors.red,Colors.green
  ] ;
  MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.teal,
      title: Text('Home'),
      centerTitle: true,
    ),
      drawer: Navigation(),
      backgroundColor: Colors.white70,
      body: FutureBuilder(
        future: getHomePost(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
        else{
          return RefreshIndicator(
            onRefresh: getRefresh,
            child: ListView.builder(
                itemCount: snapshot.data.length,
              itemBuilder: (context,index){ 
                  var ourData=snapshot.data[index];
                  color=_colorsitem[index % _colorsitem.length];
                  return Container(
                    height: 411,
                    margin: EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        //margin: EdgeInsets.only(top: 5.0),
                                         child: CircleAvatar(
                                           backgroundColor: color,
                                          child: Text(ourData.data['title'][0]),

                                        ),
                                      ),
                                      SizedBox(width: 30.0,),
                                      Container(
                                        child:Text(ourData.data['title'],style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.black54),),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(Icons.add_shopping_cart,size: 30.0,),

                                  )
                                ],
                              ),
                            ),

                            SizedBox(height: 5.0,),
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(ourData.data['image'],
                                height: 200.0, fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,),
                              ),

                            ),
                            SizedBox(height: 5.0,),
                            Container(
                              margin: EdgeInsets.all(7.0),
                              child: Text(ourData.data['desc'],maxLines: 4,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15.0
                              ),),
                            ),
                            Divider(
                              color: Colors.blueGrey,
                              height: 2.0,
                              thickness: 3.0,
                              indent: 25.0,
                              endIndent: 25.0,
                            ),
                            Align(
                              alignment:Alignment.bottomRight ,

                              child: InkWell(
                                onTap: (){
                                  customDialog(context,
                                    ourData.data['image'],
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
                            ),


                          ],
                        ),
                      ),
                    ),

                  );

              },
            ),
          );
          }},
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
              height: MediaQuery.of(context).size.height/1.7,
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

                    SizedBox(height: 10.0,),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold,color: Colors.redAccent),
                      ),
                    ),
                    Divider(
                      color: Colors.amberAccent , height: 5.0,thickness: 3.0, indent: 25.0,endIndent: 25.0,),
                    SizedBox(height: 8.0,),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: Text(

                        desc,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500,),
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
