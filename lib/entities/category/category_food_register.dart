import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CategoryFoodRegister {

  String foodId;
  String dateAdded = "";

  CategoryFoodRegister() {}

  CategoryFoodRegister.fromJsonMap(Map<String, dynamic> json) {
    foodId = json['foodId'];
    dateAdded = json['dateAdded'];
  }

  Map toJson() => {
        'foodId': foodId,
        'dateAdded': dateAdded,
      };
}
