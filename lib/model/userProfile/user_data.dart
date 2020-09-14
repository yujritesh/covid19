class UserData {
  String userEmail;
  String userName;
  String empProfileImage;
  String empNo;
  String empDesg;
  String empContactNo;
  String empQuote;
  String pic;

  UserData(
      {this.userEmail,
        this.userName,
        this.empProfileImage,
        this.empNo,
        this.empDesg,
        this.empContactNo,
        this.empQuote,
        this.pic});

  UserData.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'];
    userName = json['user_name'];
    empProfileImage = json['emp_profile_image'];
    empNo = json['emp_no'];
    empDesg = json['emp_desg'];
    empContactNo = json['emp_contact_no'];
    empQuote = json['emp_quote'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_email'] = this.userEmail;
    data['user_name'] = this.userName;
    data['emp_profile_image'] = this.empProfileImage;
    data['emp_no'] = this.empNo;
    data['emp_desg'] = this.empDesg;
    data['emp_contact_no'] = this.empContactNo;
    data['emp_quote'] = this.empQuote;
    data['pic'] = this.pic;
    return data;
  }
}