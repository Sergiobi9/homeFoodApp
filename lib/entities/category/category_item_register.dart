import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CategoryItemRegister {

  String itemId;
  String dateAdded = "";

  CategoryItemRegister() {}

  CategoryItemRegister.fromJsonMap(Map<String, dynamic> json) {
    itemId = json['itemId'];
    dateAdded = json['dateAdded'];
  }

  Map toJson() => {
        'itemId': itemId,
        'dateAdded': dateAdded,
      };
}
