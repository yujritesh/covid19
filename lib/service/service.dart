import 'dart:convert';

import 'package:covid19/model/covid19/covid19.dart';
import 'package:covid19/model/covid19/covid19_state.dart';
import 'package:covid19/model/covid19/sample.dart';
import 'package:covid19/model/covid19/state_data.dart';
import 'package:covid19/model/login/login_response.dart';
import 'package:covid19/model/userProfile/user_profile.dart';
import 'package:http/http.dart' as http;

class APIService{

  Future<UserProfile> fetchUser(String userId) async {
    String url = 'http://uxdesigndevelopment.com/intranetapp/api_list.php?opt=getEmployeeProfile&user_id=$userId';
    print("URL : $url");
    final response = await http.get(url);
    print("fetchUser RESP : ${response.body}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("response.body : ${response.body}");
      return UserProfile.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data.');
    }
  }

  Future<LoginResponse> loginUser(String email, String password) async {
    String url = "http://uxdesigndevelopment.com/intranetapp/api_list.php?opt=login&un=$email&pw=$password&reg=123123123&mac=dsqw21";
    print("URL : $url");
    final response = await http.get(url);
    print(" loginUser RESP : ${response.body}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("response.body : ${response.body}");
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("response.body : ${response.body}");
      return LoginResponse.fromJson(json.decode(response.body));
    }
  }

  //Covid19 latest data of India
  Future<Covid19> fetchIndiasCovidData() async {
    String url = 'https://api.apify.com/v2/key-value-stores/toDWvRj1JpTXiM8FF/records/LATEST?disableRedirect=true';
    print("URL : $url");
    final response = await http.get(url);
    print("fetchUser RESP : ${response.body}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("response.body : ${response.body}");
      return Covid19.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data.');
    }
  }

  Future<List<CovidStateData>> fetchStateWiseCovidData() async {

    String url = 'https://api.covid19india.org/v2/state_district_wise.json';
    print("URL : $url");
    final response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    print("State Data RESP : ${response.body}");
    print("statusCode : ${response.statusCode}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //var data = CovidStateData.fromJson(json.decode(response.body)) as Future<StateCovidData> ;
      var parsed = json.decode(response.body);
      //List<CovidStateData> list = json.decode(response.body);
      List<CovidStateData> list = List<CovidStateData>.from(parsed.map((i) => CovidStateData.fromJson(i)));
      return list;
    } else {
      print("in Error  : ${response.body}");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data.');
    }
  }

  Future<List<dynamic>> test() async {

    String url = 'https://jsonplaceholder.typicode.com/posts';
    print("URL : $url");
    final response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    print("State Data RESP : ${response.body}");
    print("statusCode : ${response.statusCode}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> list = json.decode(response.body);
      print(list);
      return list;
    } else {
      print("in Error  : ${response.body}");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data.');
    }
  }


}