import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FoodLocationSimplified {
  String foodLocationId;
  String foodLocationName = "";

  FoodLocationSimplified() {}

  FoodLocationSimplified.fromJsonMap(Map<String, dynamic> json) {
    foodLocationId = json['foodLocationId'];
    foodLocationName = json['foodLocationName'];
  }

  Map toJson() => {
        'foodLocationId': foodLocationId,
        'foodLocationName': foodLocationName,
      };
}
