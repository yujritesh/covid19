import 'login_response_data.dart';

class LoginResponse {
  String status;
  String message;
  Data data;

  LoginResponse({this.status, this.data,this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }else{
      data['message'] = this.message;
    }
    return data;
  }
}