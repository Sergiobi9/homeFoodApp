import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ItemLocationDetails {
  String id;
  String name = "";
  double latitude;
  double longitude;

  ItemLocationDetails() {}

  ItemLocationDetails.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
      };
}
