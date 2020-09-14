
import 'district_covid_data.dart';

class CovidStateData {
  String state;
  String statecode;
  List<DistrictData> districtData;

  CovidStateData({this.state, this.statecode, this.districtData});

  CovidStateData.fromJson(Map<String, dynamic> json) {

    state = json['state'];
    statecode = json['statecode'];
    if (json['districtData'] != null) {
      districtData = new List<DistrictData>();
      json['districtData'].forEach((v) {
        districtData.add(new DistrictData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    dynamic data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['statecode'] = this.statecode;
    if (this.districtData != null) {
      data['districtData'] = this.districtData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}