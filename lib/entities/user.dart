import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {

    String id;
    String firstName = "";
    String lastName = "";
    String email = "";
    String password = "";
    String userRole = "userRole";

    User(){}

    User.fromJsonMap(Map<String,dynamic> json){
      id = json['id'];
      firstName = json['firstName'];
      lastName = json['lastName'];
      email = json['email'];
      password = json['password'];
      userRole = json['userRole'];      
    }

  Map toJson() => {
        'id': id,
      'firstName':firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'userRole': userRole
      };

}