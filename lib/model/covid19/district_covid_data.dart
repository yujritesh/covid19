import 'delta.dart';

class DistrictData {
  String district;
  String notes;
  int active;
  int confirmed;
  int deceased;
  int recovered;
  Delta delta;

  DistrictData(
      {this.district,
        this.notes,
        this.active,
        this.confirmed,
        this.deceased,
        this.recovered,
        this.delta});

  DistrictData.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    notes = json['notes'];
    active = json['active'];
    confirmed = json['confirmed'];
    deceased = json['deceased'];
    recovered = json['recovered'];
    delta = json['delta'] != null ? new Delta.fromJson(json['delta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district'] = this.district;
    data['notes'] = this.notes;
    data['active'] = this.active;
    data['confirmed'] = this.confirmed;
    data['deceased'] = this.deceased;
    data['recovered'] = this.recovered;
    if (this.delta != null) {
      data['delta'] = this.delta.toJson();
    }
    return data;
  }
}
