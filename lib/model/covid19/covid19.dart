import 'package:covid19/model/covid19/covid_error.dart';

import 'region_data.dart';

class Covid19 {
  int activeCases;
  int recovered;
  int deaths;
  int totalCases;
  String sourceUrl;
  String lastUpdatedAtApify;
  String readMe;
  List<RegionData> regionData;
  Error error;

  Covid19({this.activeCases,
    this.recovered,
    this.deaths,
    this.totalCases,
    this.sourceUrl,
    this.lastUpdatedAtApify,
    this.readMe,
    this.regionData,
    this.error});

  Covid19.fromJson(Map<String, dynamic> json) {
    activeCases = json['activeCases'];
    recovered = json['recovered'];
    deaths = json['deaths'];
    totalCases = json['totalCases'];
    sourceUrl = json['sourceUrl'];
    lastUpdatedAtApify = json['lastUpdatedAtApify'];
    readMe = json['readMe'];
    if (json['regionData'] != null) {
      regionData = new List<RegionData>();
      json['regionData'].forEach((v) {
        regionData.add(new RegionData.fromJson(v));
      });
    }
    if(json['error'] != null){
      error = Error();
      error = json['error'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activeCases'] = this.activeCases;
    data['recovered'] = this.recovered;
    data['deaths'] = this.deaths;
    data['totalCases'] = this.totalCases;
    data['sourceUrl'] = this.sourceUrl;
    data['lastUpdatedAtApify'] = this.lastUpdatedAtApify;
    data['readMe'] = this.readMe;
    if (this.regionData != null) {
      data['regionData'] = this.regionData.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}
