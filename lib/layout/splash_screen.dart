import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'covid_dashboard.dart';

class SplashScreenWidget extends StatefulWidget {
  //MyHomePage(LoginResponse futureLogin, {Key key, this.title, LoginResponse data}) : super(key: key);

  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}
DateTime currentBackPressTime;

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(msg: "Tap again to exit app");
    return Future.value(false);
  }
  return Future.value(true);
}


class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  double _width = 20;
  double _height = 20;
  double _radius = 20.0;
  //var _colour = Colors.blue;
  var background_color =Colors.transparent;
  double _updateState() {
    setState(() {
        _width = 500;
        _height = 700;
        background_color = Colors.redAccent;
        _radius =50.0;
    });
  }


  @override
  void initState() {
    super.initState();
    Future.delayed(new Duration(seconds: 1), () {
      _updateState();
    });
    Future.delayed(new Duration(seconds: 3), () {
      Navigator.push(context, SlideRightRoute(page: COVIDDashboardWidget()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(

                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 2500),
                      curve: Curves.bounceOut,
                      width: _width,
                      height: _height,
                      color: background_color,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: _radius,
                              child: Image.asset(
                                "images/flutter_icon.webp",
                                width: 80,
                                height: 80,
                              ),
                              /*child: Icon(
                                Icons.android,
                                color: Colors.greenAccent,
                                size: 50,
                              ),*/
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  /*Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50.0,
                            child: Image.asset(
                              "images/flutter_icon.webp",
                              width: 80,
                              height: 80,
                            ),
                            *//*child: Icon(
                                Icons.android,
                                color: Colors.greenAccent,
                                size: 50,
                              ),*//*
                          )
                        ],
                      ),
                    ),
                  )*/
                ],
              )
              /*Container(
                  width: MediaQuery.of(context).copyWith().size.width,
                  height: MediaQuery.of(context).copyWith().size.height ,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                      padding: EdgeInsets.all(30),
                      child: Image.asset("images/flutter_icon.webp")),
                ),*/
            ],
          ),
        ),
      ),
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}