import 'package:flutter/material.dart';

class CustomToolbar extends StatefulWidget {

  CustomToolbar(String title){
    screenTitle = title;
  }

  @override
  _CustomToolbarState createState() => _CustomToolbarState();


}

String screenTitle = "";
class _CustomToolbarState extends State<CustomToolbar>{

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156,
      child: Scaffold(
          appBar: AppBar(
            title: Text(screenTitle),
          )
      ),
    );
  }

}