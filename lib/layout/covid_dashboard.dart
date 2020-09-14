
import 'package:covid19/model/covid19/covid19.dart';
import 'package:covid19/model/covid19/precaution.dart';
import 'package:covid19/model/covid19/symptoms.dart';
import 'package:covid19/service/service.dart';
import 'package:covid19/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:intl/intl.dart";
import 'package:after_init/after_init.dart';

import '../constant.dart';
import 'state_wise_covid_data.dart';

import 'package:responsive_container/responsive_container.dart';

class COVIDDashboardWidget extends StatefulWidget {
  //MyHomePage(LoginResponse futureLogin, {Key key, this.title, LoginResponse data}) : super(key: key);
  //COVIDDashboardWidget.forDesignTime();
  @override
  _COVIDDashboardState createState() => _COVIDDashboardState();
}


Future<Covid19> covidData;

int infected = 0;
int deaths = 0;
int recovered = 0;
int totalCases = 0;
String currentDate = "";


class _COVIDDashboardState extends State<COVIDDashboardWidget> with AfterInitMixin<COVIDDashboardWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext mContext;
  @override
  void initState() {
    super.initState();
    var now = new DateTime.now();
    currentDate = new DateFormat("dd MMM, yyyy").format(now);

    //_callFetchCovidDataApi();
    /*fetchUser().then((s) => setState(() {
      _userProfile = s;
      _isLoaded = true;
    }));*/
  }

  @override
  void didInitState() {
    // No need to call super.didInitState().
    // setState() is not required because build() will automatically be called by Flutter.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_callFetchCovidDataApi();
    Future.delayed(Duration.zero, this._onLoading);
  }

  void _openDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(

                  image: DecorationImage(
                      image: AssetImage('images/stay_at_home.webp'),
                      fit: BoxFit.fill

                  )
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                title: Text('Symptoms'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.push(context, SlideRightRoute(page: SymptomsWidget()));
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                title: Text('Precautions'),
                onTap: () {
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.push(context, SlideRightRoute(page: PrecautionWidget()));
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          /*width: MediaQuery.of(context).copyWith().size.width / 3,
          height: MediaQuery.of(context).copyWith().size.width / 3,*/
          child: Column(
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 45.0 * SizeConfig.heightMultiplier,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Color(0xFF3383CD),
                            Color(0xFF11249F)
                          ]
                      ),
                      image: DecorationImage(
                          image: AssetImage('images/virus.webp')
                      )
                  ),
                  child:Container(
                    child: ListView(

                      children: <Widget>[
                        SizedBox(height:30),

                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 2 * SizeConfig.heightMultiplier),
                          child: GestureDetector(
                            onTap: () {
                              _openDrawer();
                            },
                            child: SvgPicture.asset("images/menu.svg"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 2 * SizeConfig.heightMultiplier),
                                      child: SvgPicture.asset(
                                        'images/drcorona.svg',
                                        width: 56.0 * SizeConfig.imageSizeMultiplier,
                                        fit: BoxFit.fitWidth,
                                        alignment: Alignment.topCenter,
                                      ),
                                    ),
                                    Positioned(
                                      top: 5.5 * SizeConfig.heightMultiplier,
                                      left: 26.3 * SizeConfig.heightMultiplier,
                                      child: Text(
                                          "All you need is \n stay at home",
                                          style: kHeadingTextStyle.copyWith(color: Colors.white)
                                      ),
                                    ),
                                    Container()
                                  ],
                                ),
                              ),
                            ],
                          ),

                        )

                      ],
                    ),
                  )

                ),
              ),

              Container(
                alignment: Alignment.topCenter,
                width: double.infinity,
                child: Text(
                  "India",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                ),),
              ),
              SizedBox(height: 10,),

              //Case details
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(

                              children: [TextSpan(text: "Case Update\n",style: kTitleTextstyle,),
                                TextSpan(text: "Newest Update $currentDate",style: TextStyle(color: kTextLightColor))
                              ]
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(text: "Show Details",style: TextStyle(color: Colors.blue,fontSize: 16))
                                ]
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, SlideRightRoute(page: StateWidget()));
                            /*Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => StateWidget()),
                            );*/
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: FutureBuilder<Covid19>(
                          future: covidData,
                          builder: (context,snapshot){
                            if (snapshot.hasData) {
                              totalCases = snapshot.data.totalCases;
                              infected = snapshot.data.activeCases;
                              deaths = snapshot.data.deaths;
                              recovered = snapshot.data.recovered;
                              return Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        CounterCard(color: kTotalColor,number:totalCases,title:"Total Cases"),
                                        SizedBox(width: 20,),
                                        CounterCard(color: kInfectedColor,number:infected,title:"Infected")
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        CounterCard(color: kRecovercolor,number:recovered,title:"Recovered"),
                                        SizedBox(width: 20,),
                                        CounterCard(color: kDeathColor,number:deaths,title:"Deaths")
                                      ],
                                    ),
                                    SizedBox(height: 20,)
                                  ],
                                ),

                              );

                              /*return Container(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 30,
                                          color: kShadowColor,
                                        )
                                      ]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      COVIDCounter(color: kTotalColor,number:totalCases,title:"Total Cases"),
                                      COVIDCounter(color: kInfectedColor,number:infected,title:"Infected"),
                                      COVIDCounter(color: kRecovercolor,number:recovered,title:"Recovered"),
                                      COVIDCounter(color: kDeathColor,number:deaths,title:"Deaths"),
                                    ],
                                  ),
                                ),
                              );*/
                            }else{
                              if(snapshot.error == null){
                                return Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          CounterCard(color: kTotalColor,number:0,title:"Total Cases"),
                                          SizedBox(width: 20,),
                                          CounterCard(color: kInfectedColor,number:0,title:"Infected")
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          CounterCard(color: kRecovercolor,number:0,title:"Recovered"),
                                          SizedBox(width: 20,),
                                          CounterCard(color: kDeathColor,number:0,title:"Deaths")
                                        ],
                                      ),
                                      SizedBox(height: 20,)
                                    ],
                                  ),

                                );
                              }else{
                                return Text("${snapshot.error}");
                              }
                            }
                          }
                      ),
                    ),

                  ],
                ),
              )


            ],
          ),
        ),

      ),
    );
  }

  void _callFetchCovidDataApi() {
    CircularProgressIndicator();
    covidData = APIService().fetchIndiasCovidData();
    //print("_callFetchCovidDataApi : $covidData");
    covidData.then((covid) {
      setState(() {
        if(covid.error == null){
          /*Fluttertoast.showToast(
              msg: "Data Updated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );*/
          totalCases = covid.totalCases;
          infected = covid.activeCases;
          deaths = covid.deaths;
          recovered = covid.recovered;
          var updatedDate = converDateTime(covid.lastUpdatedAtApify);
          currentDate = new DateFormat("dd MMM, yyyy hh:mm a").format(updatedDate);
          Navigator.pop(context); //pop dialog

        }else{
          Fluttertoast.showToast(
              msg: covid.error.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

          Navigator.pop(context); //pop dialog

        }

      });
    }, onError: (error) {
      setState(() {
        print("error: $error");
        Fluttertoast.showToast(
            msg: error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      });
    });
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20,),
                Text("Loading"),
              ],
            ),
          )

        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {

      _callFetchCovidDataApi();
    });
  }
}






class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0,size.height-80);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height-80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}

class CounterCard extends StatelessWidget{
  final int number;
  final Color color;
  final String title;
  const CounterCard({
    Key key, this.number, this.color, this.title,

  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 20.0,
                  offset: Offset(0, 10)
              )

            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            COVIDCounter(color: color,number:number,title:title),

          ],
        ),
      ),
    );
  }

}

class COVIDCounter extends StatelessWidget{

  final int number;
  final Color color;
  final String title;
  const COVIDCounter({
    Key key, this.number, this.color, this.title,

  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).copyWith().size.width / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(6),
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(.26)
            ),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                      color: color,
                      width: 2
                  )
              ),
            ),
          ),

          SizedBox(height: 10,),
          Text(
            '${NumberFormat.compactCurrency(
              decimalDigits: 0,
              symbol: '',
            ).format(number)}',
            style: TextStyle(fontSize: 30,color: color),
          ),
          Text(
            title,
            style: kSubTextStyle,
          ),

        ],
      ),
    );
  }

}


DateTime converDateTime(String dateUtc){
  DateTime todayDate = DateTime.parse(dateUtc);
  todayDate = DateTime.utc(todayDate.year,todayDate.month,todayDate.day,todayDate.hour,todayDate.minute,todayDate.second);
  final convertedDate = todayDate.toLocal();
  print(todayDate);
  print(convertedDate);
  return convertedDate;
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