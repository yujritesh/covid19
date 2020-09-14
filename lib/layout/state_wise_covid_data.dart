import 'package:covid19/model/covid19/covid19.dart';
import 'package:covid19/model/covid19/covid19_state.dart';
import 'package:covid19/model/covid19/state_data.dart';
import 'package:covid19/service/service.dart';
import 'package:flutter/material.dart';
import 'package:after_init/after_init.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:intl/intl.dart";
import '../constant.dart';


class StateWidget extends StatefulWidget {
  //MyHomePage(LoginResponse futureLogin, {Key key, this.title, LoginResponse data}) : super(key: key);

  @override
  _COVIDStateDetailsState createState() => _COVIDStateDetailsState();
}


var currentSelectedValue = 'Andaman and Nicobar Islands';
var currentSelectedDistrict ='North and Middle Andaman';
Future<Covid19> covidData;
Future<List<CovidStateData>> stateCovidData;
String latestUpdatedDateTime = "";

int infected = 0;
int deaths = 0;
int recovered = 0;

int distInfected = 0;
int distDeaths = 0;
int distRecovered = 0;

List<String> districtList =List();
bool isDistrict;

class _COVIDStateDetailsState extends State<StateWidget>
    with AfterInitMixin<StateWidget> {

  @override
  void initState() {
    super.initState();
    var now = new DateTime.now();
    latestUpdatedDateTime = new DateFormat("dd MMM, yyyy").format(now);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_callFetchCovidDataApi();
    isDistrict = false;
    Future.delayed(Duration.zero, this._onLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Case Update\n", style: kTitleTextstyle,),
                            TextSpan(text: "Newest Update $latestUpdatedDateTime",
                                style: TextStyle(color: kTextLightColor))
                          ]
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("State", style: kTitleTextstyle,),
              SizedBox(height: 10,),
              //Dropdown
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Color(0xFFE5E5E5)),
                    boxShadow: [
                    BoxShadow(
                    offset: Offset(0, 4),
                blurRadius: 30,
                color: Colors.black38,
              )
            ]
                ),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'images/maps_and_flags.svg',
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.blue,
                          size: 20.0,
                        ),
                        value: currentSelectedValue,
                        hint: Text('Select your state'),
                        items: stateList.map<DropdownMenuItem<String>>((
                            String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            currentSelectedValue = value;
                          });
                          print("===== OnChanged Called =====");
                          isDistrict = false;

                          _onLoading();
                        },

                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(height: 10,),
              //Case details
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[

                    SizedBox(height: 20,),
                    Container(
                      child: FutureBuilder<Covid19>(
                          future: covidData,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 30,
                                        color: Colors.black38,
                                      )
                                    ]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: <Widget>[
                                    COVIDCounter(color: kInfectedColor,
                                        number: infected,
                                        title: "Infected"),
                                    COVIDCounter(color: kRecovercolor,
                                        number: recovered,
                                        title: "Recovered"),
                                    COVIDCounter(color: kDeathColor,
                                        number: deaths,
                                        title: "Deaths"),
                                  ],
                                ),
                              );
                            } else {
                              if (snapshot.error == null) {
                                return Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 30,
                                          color: Colors.black38,
                                        )
                                      ]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      COVIDCounter(color: kInfectedColor,
                                          number: 0,
                                          title: "Infected"),
                                      COVIDCounter(color: kRecovercolor,
                                          number: 0,
                                          title: "Recovered"),
                                      COVIDCounter(color: kDeathColor,
                                          number: 0,
                                          title: "Deaths"),
                                    ],
                                  ),
                                );
                              } else {
                                return Text("${snapshot.error}");
                              }
                            }
                          }
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 30),
              //District Data

              //Dropdown
              Text("District", style: kTitleTextstyle,),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Color(0xFFE5E5E5)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 30,
                        color: Colors.black38,
                      )
                    ]
                ),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'images/maps_and_flags.svg',
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.blue,
                          size: 20.0,
                        ),
                        value: currentSelectedDistrict,
                        hint: Text('Select your state'),
                        items: districtList.map<DropdownMenuItem<String>>((
                            String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            currentSelectedDistrict = value;
                          });
                          print("===== OnChanged Called =====");
                          isDistrict = true;
                          _onLoading();
                        },

                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(height: 10,),
              //Case details
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[

                    SizedBox(height: 20,),
                    Container(
                      child: FutureBuilder<List<CovidStateData>>(
                          future: stateCovidData,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 30,
                                        color: Colors.black38,
                                      )
                                    ]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: <Widget>[
                                    COVIDCounter(color: kInfectedColor,
                                        number: distInfected,
                                        title: "Infected"),
                                    COVIDCounter(color: kRecovercolor,
                                        number: distRecovered,
                                        title: "Recovered"),
                                    COVIDCounter(color: kDeathColor,
                                        number: distDeaths,
                                        title: "Deaths"),
                                  ],
                                ),
                              );
                            } else {
                              if (snapshot.error == null) {
                                return Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 30,
                                          color: Colors.black38,
                                        )
                                      ]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      COVIDCounter(color: kInfectedColor,
                                          number: 0,
                                          title: "Infected"),
                                      COVIDCounter(color: kRecovercolor,
                                          number: 0,
                                          title: "Recovered"),
                                      COVIDCounter(color: kDeathColor,
                                          number: 0,
                                          title: "Deaths"),
                                    ],
                                  ),
                                );
                              } else {
                                return Text("${snapshot.error}");
                              }
                            }
                          }
                      ),
                    ),
                    SizedBox(height: 140,),
                  ],
                ),
              )

              // District data end

            ],
          ),
        )
    );
  }

  @override
  void didInitState() {

  }

  void _callFetchCovidDataApi() {
    CircularProgressIndicator();
    covidData = APIService().fetchIndiasCovidData();
    print("_callFetchCovidDataApi : $covidData");
    covidData.then((covid) {
      setState(() {
        if (covid.error == null) {

          for (var state in covid.regionData) {
            if (state.region == currentSelectedValue) {
              infected = state.totalInfected;
              deaths = state.deceased;
              recovered = state.recovered;
              isDistrict = true;
              Future.delayed(Duration.zero, this._onLoading);
              break;
            }
          }

          var updatedDate = converDateTime(covid.lastUpdatedAtApify);
          latestUpdatedDateTime = new DateFormat("dd MMM, yyyy hh:mm a").format(updatedDate);
          Navigator.pop(context); //pop dialog

        } else {
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
      if(isDistrict){
        _callFetchStateCovidDataApi();
      }else {
        _callFetchCovidDataApi();
      }
    });
  }

  void _callFetchStateCovidDataApi() {
    CircularProgressIndicator();
    stateCovidData = APIService().fetchStateWiseCovidData();
    print("fetchStateWiseCovidData : $stateCovidData");
    stateCovidData.then((stateData) {
      setState(() {

          Fluttertoast.showToast(
              msg: "District Data Updated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          districtList.clear();

          for(var state in stateData){
            print("State : ${state.state}");
            if(state.state == currentSelectedValue) {
              if(currentSelectedDistrict.isEmpty) {
                currentSelectedDistrict = state.districtData[0].district;
              }
              for (var district in state.districtData) {
                print("District : ${district.district}");
                districtList.add(district.district);
              }
              break;
            }
          }

          if(!districtList.contains(currentSelectedDistrict)){
            currentSelectedDistrict = districtList[0];
            print("==== Selected District : $currentSelectedDistrict");
          }


          print("District size : ${districtList.length}");
          for(var state in stateData) {
            for (var dist in state.districtData) {
              if (dist.district == currentSelectedDistrict) {
                distInfected = dist.confirmed;
                distDeaths = dist.deceased;
                distRecovered = dist.recovered;
                break;
              }
            }
          }

          Navigator.pop(context); //pop dialog

        /*} else {
          Fluttertoast.showToast(
              msg: stateData.error.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

          Navigator.pop(context); //pop dialog

        }*/
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
        Navigator.pop(context); //pop dialog
      });
    });
  }

}

class COVIDCounter extends StatelessWidget {

  final int number;
  final Color color;
  final String title;

  const COVIDCounter({
    Key key, this.number, this.color, this.title,

  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          style: TextStyle(fontSize: 30, color: color),
        ),
        Text(
          title,
          style: kSubTextStyle,
        ),

      ],
    );
  }

}

DateTime converDateTime(String dateUtc){
  DateTime todayDate = DateTime.parse(dateUtc);
  todayDate = DateTime.utc(todayDate.year,todayDate.month,todayDate.day,todayDate.hour,todayDate.minute,todayDate.second);
  final convertedDate = todayDate.toLocal();
  /*print(todayDate);
  print(convertedDate);*/
  return convertedDate;
}