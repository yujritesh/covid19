import 'package:covid19/model/covid19/covid19_state.dart';
import 'package:covid19/model/covid19/state_data.dart';
import 'package:covid19/model/login/login_response.dart';
import 'package:covid19/utils/screen_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'layout/covid_dashboard.dart';
import 'layout/splash_screen.dart';
import 'service/service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
       builder: (context,constraints){
        return OrientationBuilder(
             builder : (context,orientation) {
               SizeConfig().init(constraints, orientation);
               return MaterialApp(
                 title: 'COVID19',
                 debugShowCheckedModeBanner: false,
                 theme: ThemeData(
                   primarySwatch: Colors.blue,
                   visualDensity: VisualDensity.adaptivePlatformDensity,
                 ),
                 home: SplashScreenWidget(),
               );

             }
         );
       },
    );
  }
}

Future<List<dynamic>> futureLogin;
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

String enteredEmail = "";
String enteredPass = "";
// Design For login page

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _callLoginApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/background.png'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/light-1.png')
                              )
                          ),
                        ),
                      ),

                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/light-2.png')
                              )
                          ),
                        ),
                      ),

                      Positioned(
                        right: 40,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/clock.png')
                              )
                          ),
                        ),
                      ),

                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),


                Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
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
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email or Phone number",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                                autofocus: true,
                                controller: emailController,
                                onChanged: (text){
                                  emailController.addListener(() {
                                    enteredEmail = text;
                                  });
                                },
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[400]),
                                    icon: const Padding(
                                        padding: const EdgeInsets.only(top: 15.0),
                                        child: const Icon(Icons.lock))),
                                  validator: (val) => val.length < 6 ? 'Password too short.' : null,
                                  onSaved: (val) =>  enteredPass = val,
                                  autofocus: true,
                                  obscureText: true,
                                  controller: passwordController,
                                  onChanged: (text){
                                    passwordController.addListener(() {
                                      enteredPass = text;
                                    });
                                  }
                                ),

                              ),

                          ],
                        ),

                      ),


                      SizedBox(height: 30,),
                      InkWell(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[400],
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10)
                                )
                              ]
                          ),
                          child: Center(
                            child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        ),
                        onTap: (){

                          //_callLoginApi(emailController.text, passwordController.text);

                          /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DashboardWidget()),
                          );*/
                        },
                      ),





                      SizedBox(height: 70,),
                      Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)

                    ],
                  ),
                )

              ],
            ),
        ),
      ),
    );
  }
  void _callLoginApi() {
    futureLogin = APIService().test();
    print("futureLogin : $futureLogin");
    futureLogin.then((login) {
      setState(() {
        Fluttertoast.showToast(
            msg: "Login Success !!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

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
}


