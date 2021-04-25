import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FoodLocation {
  String id;
  String name = "";
  double latitude;
  double longitude;
  String street = "";
  String familyId = "";
  String creatorId = "";
  String dateAdded = "";

  FoodLocation() {}

  FoodLocation.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    street = json['street'];
    familyId = json['familyId'];
    creatorId = json['creatorId'];
    dateAdded = json['dateAdded'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'street': street,
        'familyId':familyId,
        'creatorId': creatorId,
        'dateAdded': dateAdded
      };
}
