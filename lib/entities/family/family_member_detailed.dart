import 'package:home_food_project/utils/date_utils.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FamilyMemberDetailed {
  
  String userId = "";
  String firstName = "";
  String lastName = "";
  String dateAdded = "";
  String userRole = "";

  FamilyMemberDetailed() {}

  FamilyMemberDetailed.fromJsonMap(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dateAdded = json['dateAdded'];
    userRole = json['userRole'];
  }

  Map toJson() => {
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'dateAdded': dateAdded,
        'userRole': userRole,
      };
}
