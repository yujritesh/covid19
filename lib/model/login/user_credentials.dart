class UserCredentials {
  final String password;
  final String email;

  UserCredentials(this.password, this.email);

  UserCredentials.fromJson(Map<String, dynamic> json)
      : password = json['password'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      {
        'password': password,
        'email': email,
      };
}