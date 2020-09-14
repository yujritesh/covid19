class Delta {
  int confirmed;
  int deceased;
  int recovered;

  Delta({this.confirmed, this.deceased, this.recovered});

  Delta.fromJson(Map<String, dynamic> json) {
    confirmed = json['confirmed'];
    deceased = json['deceased'];
    recovered = json['recovered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirmed'] = this.confirmed;
    data['deceased'] = this.deceased;
    data['recovered'] = this.recovered;
    return data;
  }
}