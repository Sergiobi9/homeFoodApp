import 'package:home_food_project/utils/date_utils.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FamilyMemberRegister {

  String userId = "";
  String dateRegistered = "";

  FamilyMemberRegister(String userId) {
    this.userId = userId;
    this.dateRegistered = DateUtilsHelper.timeStamp();
  }

  FamilyMemberRegister.fromJsonMap(Map<String, dynamic> json) {
    userId = json['userId'];
    dateRegistered = json['dateRegistered'];
  }

  Map toJson() => {
        'userId': userId,
        'dateRegistered': dateRegistered,
      };
}
