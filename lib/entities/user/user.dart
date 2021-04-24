import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  String id;
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String uid = "";
  String dateRegistered = "";
  String userRole = "";

  User() {}

  User.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    uid = json['uid'];
    dateRegistered = json['dateRegistered'];
    userRole = json['userRole'];
  }

  Map toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'uid':uid,
        'dateRegistered': dateRegistered,
        'userRole': userRole
      };
}
