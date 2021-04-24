import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  String id;
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String dateRegistered = "";
  String userRole = "userRole";

  User() {}

  User.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    dateRegistered = json['dateRegistered'];
    userRole = json['userRole'];
  }

  Map toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'dateRegistered': dateRegistered,
        'userRole': userRole
      };
}
