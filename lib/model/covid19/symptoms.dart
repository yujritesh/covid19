import 'package:covid19/custom_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:after_init/after_init.dart';
class SymptomsWidget extends StatefulWidget {
  //MyHomePage(LoginResponse futureLogin, {Key key, this.title, LoginResponse data}) : super(key: key);
  //COVIDDashboardWidget.forDesignTime();
  @override
  _SymptomsState createState() => _SymptomsState();
}


class _SymptomsState extends State<SymptomsWidget> with AfterInitMixin<SymptomsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            CustomToolbar("Symptoms"),
            Container(

              /*decoration: BoxDecoration(
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
              ),*/
              child: Image.asset("images/symptoms.jpg"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didInitState() {

  }

}