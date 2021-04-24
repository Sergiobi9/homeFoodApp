import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AuthenticationData {
  String email;
  String password;

  AuthenticationData(email, password) {
    this.email = email;
    this.password = password;
  }

  AuthenticationData.fromJsonMap(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  toString() {
    print(email + " " + password);
  }

  Map toJson() => {
        'email': email,
        'password': password,
      };
}
