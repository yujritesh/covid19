class Data {
  String userId;
  String userName;
  String typeId;
  String userEmail;
  String userRole;

  Data(
      {this.userId, this.userName, this.typeId, this.userEmail, this.userRole});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    typeId = json['type_id'];
    userEmail = json['user_email'];
    userRole = json['user_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['type_id'] = this.typeId;
    data['user_email'] = this.userEmail;
    data['user_role'] = this.userRole;
    return data;
  }
}