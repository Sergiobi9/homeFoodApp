import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ItemLocationRegisterSimplified {
  String id;
  String name = "";
  String familyId = "";
  String creatorId = "";
  String dateAdded = "";

  ItemLocationRegisterSimplified() {}

  ItemLocationRegisterSimplified.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    familyId = json['familyId'];
    creatorId = json['creatorId'];
    dateAdded = json['dateAdded'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'familyId':familyId,
        'creatorId': creatorId,
        'dateAdded': dateAdded
      };
}
