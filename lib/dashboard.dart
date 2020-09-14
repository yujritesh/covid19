import 'package:covid19/model/login/login_response.dart';
import 'package:flutter/material.dart';
import 'custom_toolbar.dart';
import 'model/userProfile/user_profile.dart';

import 'dart:async' show Future;


Future<UserProfile> futureUser;

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  LoginResponse loginResponse;
  //MyHomePage(LoginResponse futureLogin, {Key key, this.title, LoginResponse data}) : super(key: key);
  MyHomePage( {LoginResponse data}){
    this.loginResponse = data;
  }


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    CircularProgressIndicator();
    //futureUser = APIService().fetchUser(widget.loginResponse.data.userId);

    /*fetchUser().then((s) => setState(() {
      _userProfile = s;
      _isLoaded = true;
    }));*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: CustomToolbar("Dashboard"),
          ),

          Container(
            padding: EdgeInsets.all(30),
            child: FutureBuilder<UserProfile>(
              future: futureUser,
              builder: (context,snapshot){

                  if (snapshot.hasData) {
                    return Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(20),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[400],
                                                blurRadius: 20.0,
                                                offset: Offset(0, 10)
                                            )
                                          ]
                                      ),

                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(8),

                                            child: Column(
                                              children: <Widget>[
                                                /*FadeInImage.memoryNetwork(
                                                  placeholder: AssetImage("images/default_profile.webp"),
                                                  image: 'https://www.evolutionsociety.org/userdata/news_picupload/pic_sid189-0-norm.jpg',
                                                ),*/

                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(100),
                                                  child: FadeInImage.assetNetwork(
                                                      placeholder: 'images/default_profile.webp',
                                                      image: 'https://www.evolutionsociety.org/userdata/news_picupload/pic_sid189-0-norm.jpg', width: 100,height: 100,fit: BoxFit.cover
                                                  ),
                                                ),
                                                /*FadeInImage.assetNetwork(
                                                    placeholder: 'images/default_profile.webp',
                                                    image: 'https://www.evolutionsociety.org/userdata/news_picupload/pic_sid189-0-norm.jpg', width: 100,height: 100,fit: BoxFit.contain
                                                ),*/
                                                SizedBox(height: 20,),
                                                _buildProfileInfoRow("Name",snapshot.data.data.userName),
                                                SizedBox(height: 10,),
                                                _buildProfileInfoRow("Email",snapshot.data.data.userEmail),
                                                SizedBox(height: 10,),
                                                _buildProfileInfoRow("Mobile",snapshot.data.data.empContactNo),
                                                SizedBox(height: 10,),
                                                _buildProfileInfoRow("Emp Designanation",snapshot.data.data.empDesg),
                                              ],
                                            ),
                                          ),



                                        ],
                                      ),

                                    )

                                  ],
                                )
                            ),



                          ],
                        ),
                    );
                  }else{
                    if(snapshot.error == null){
                      return CircularProgressIndicator();
                    }else{
                      return Text("${snapshot.error}");
                    }


                  }

              },

            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Row _buildProfileInfoRow(String label,String labelData) {
  return Row(

    children: <Widget>[
      Expanded(
        flex: 2,
        child: Text(label, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),),
      ),
      Expanded(
        flex: 3,
        child: Text(labelData, style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.normal),),
      ),


    ],
  );
}
