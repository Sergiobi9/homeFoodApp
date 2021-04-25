import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ItemLocationSimplified {
  String itemLocationId;
  String itemLocationName = "";

  ItemLocationSimplified() {}

  ItemLocationSimplified.fromJsonMap(Map<String, dynamic> json) {
    itemLocationId = json['itemLocationId'];
    itemLocationName = json['itemLocationName'];
  }

  Map toJson() => {
        'itemLocationId': itemLocationId,
        'itemLocationName': itemLocationName,
      };
}
