import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FamilyMemberUserRequest {

  String userId = "";
  String firstName = "";
  String lastName = "";
  String email = "";

  FamilyMemberUserRequest() {}

  FamilyMemberUserRequest.fromJsonMap(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
  }

  Map toJson() => {
        'id': userId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };
}
