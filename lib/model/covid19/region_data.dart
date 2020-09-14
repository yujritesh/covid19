class RegionData {
  String region;
  int totalInfected;
  int recovered;
  int deceased;

  RegionData({this.region, this.totalInfected, this.recovered, this.deceased});

  RegionData.fromJson(Map<String, dynamic> json) {
    region = json['region'];
    totalInfected = json['totalInfected'];
    recovered = json['recovered'];
    deceased = json['deceased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region'] = this.region;
    data['totalInfected'] = this.totalInfected;
    data['recovered'] = this.recovered;
    data['deceased'] = this.deceased;
    return data;
  }
}